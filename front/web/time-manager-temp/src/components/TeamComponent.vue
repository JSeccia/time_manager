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
                            <!-- <td>{{ ManagerName[0] }}</td> -->
                            <td>{{team.manager.username}}({{team.manager.id}})</td>
                            <td><ul><li class="team_members" v-for="u in team.users" :key="u.id">{{ u.username }}</li></ul></td>
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
                    <tr v-for="u in teamUsers" class="T_items" :key="u.id">
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
            team: {manager: {username: '', id: ''}, users: []},

            teamUsers: [],
        }
    },
    methods: {
        getTeamForAdmin() {
            if (this.currentUser.role === 'admin') {
                axios
                    .get(`/api/teams/${this.teamId}`)
                    .then((response) => {
                        console.log(response.data, "team");
                        this.team = response.data
                        });
                    }
            },


        // },
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
                    .get(`/api/teams/manager/${this.currentUser.id}`)
                    .then((response) => {
                        // console.log(response.data, "Apiusers");
                        this.teamUsers = response.data.users;
                        const currentUserTeamId = response.data.id
                        // this.ManagerTeam = users.filter((u) => u.team_id === currentUserTeamId[0]);
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