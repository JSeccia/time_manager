<template>
    <main class="main_teams">
        <section v-if="currentUser.role === 'admin'" class="managing_teams">


            <h1>Team n°{{ teamId }} Details</h1>

            <div class="display-teams">
                <table class="teams-table">
                    <thead>
                        <th>
                        <td>Manager</td>
                        <td>Team Members</td>
                        <td>Actions</td>
                        </th>
                    </thead>
                    <tbody>
                        <tr class="T_items">
                            <td>{{ ManagerName[0] }}</td>
                            <td class="team_members" v-for="t in team" :key="t.user">{{ t.user }}</td>

                            <td>
                                <input class="delete-button" type="button" value="🗑" @click="deleteTeam" />
                            </td>

                        </tr>
                    </tbody>

                </table>
            </div>
        </section>

        <section v-if="currentUser.role === 'manager'" class="managing_teams">
            <h1>My Team members</h1>
            <table class="teams-table">
                <thead>
                    <th>
                    <td>Id</td>
                    <td>Name</td>
                    <td>Email</td>
                    </th>
                </thead>
                <tbody>
                    <tr v-for="u in ManagerTeam" class="T_items" :key="u.id">
                        <td>
                            {{ u.id }}
                        </td>
                        <td>
                            {{ u.username }}
                        </td>
                        <td>
                            {{ u.email }}
                        </td>
                    </tr>
                </tbody>

            </table>

        </section>

    </main>

</template>

<script>
import axios from 'axios';
import { useUserStore } from 'src/stores/store-users';


export default {
    name: "TeamPage",
    setup() {
        const store = useUserStore();
        return {
            store
        }
    },
    data() {
        return {
            currentUser: this.store.user,
            teamId: this.$route.params.teamId,
            team: {},
            ManagerName: [],
            ManagerTeamId: "",
            ManagerTeam: {},
        }
    },
    methods: {
        getTeamForAdmin() {
            if (this.currentUser.role === 'admin') {
                axios
                    .get(`/api/teams/${this.teamId}`)
                    .then((response) => {
                        console.log(response.data, "team");
                        this.team = response.data.users.map((t) => {
                            return {
                                id: t.team_id,
                                user: t.username
                            }
                        });
                        const retrieveManager = this.team.splice(0, 1);
                        console.log(retrieveManager, "retrieve manager");

                        console.log(this.team, "teamUsers");
                        this.ManagerName = response.data.users.filter((t) => t.role === "manager").map((t) => {
                            return t.username

                        });
                        console.log(this.ManagerName, "manager");
                    })
            }


        },
        deleteTeam() {
            console.log("Delete team button clicked");
            if (confirm("Are you sure you want to delete this team?")) {
                axios.delete(`/api/teams/${this.teamId}`)
                    .then((response) => {
                        this.$router.push({ path: `/teams` })
                            .then(() => { this.$router.go() })
                    })
            }
        },
        getTeamForManager() {
            if (this.currentUser.role === 'manager') {
                axios
                    .get(`/api/users`)
                    .then((response) => {
                        console.log(response.data.data, "Apiusers");
                        const users = response.data.data;
                        const currentUser = users.filter((u) => u.username === this.currentUser.username);
                        const currentUserTeamId = currentUser.map((u) => u.team_id);
                        this.ManagerTeam = users.filter((u) => u.team_id === currentUserTeamId[0]);
                        console.log(this.ManagerTeam, "ManagerTeam");
                    })
            }




        }

    },
    mounted() {
        this.getTeamForAdmin();
        this.getTeamForManager();
    },
};
</script>

<style>
.team_members {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
}

.T_items {
    display: flex;
    justify-content: center;
    align-items: center;
}

.T_items td {
    width: 40%;
}

.T_items td:nth-child(1) {
    border-right: 1px solid black;
}

.T_items td:last-child {
    border-left: 1px solid black;
}

.T_items .team_members {
    width: 10%;
    flex-wrap: wrap;
}
</style>