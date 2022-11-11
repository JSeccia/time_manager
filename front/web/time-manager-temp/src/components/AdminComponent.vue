<template>
    <main v-if="currentUser.role === 'admin'">
        <h1>Admin Dashboard Page</h1>


        <section class="managing_users">

            <div class="managing-users-head">
                <h3>Managing Users</h3>
            </div>

            <div class="display-users">
                <table class="users-table">
                    <thead>
                        <th>
                        <td>Id Number</td>
                        <td>Username</td>
                        <td>Email</td>
                        <td>Role</td>
                        <td>Team Group</td>
                        </th>
                    </thead>
                    <tbody>
                        <tr class="U_items" v-for="user in users" :key="user.id">
                            <td>
                                <input type="button" :value="user.id" @click.prevent="goUserShow" />
                            </td>
                            <td>{{ user.username }}</td>
                            <td>{{ user.email }}</td>
                            <td>{{ user.role }}</td>
                            <td>{{ user.team_id }}</td>
                            <td>
                            </td>
                        </tr>
                    </tbody>

                </table>
            </div>

           
        </section>

        <section class="managing_teams">
            <div>
                <h3>Managing Teams</h3>
            </div>
            
        </section>

        <div class="managing_managers">

        </div>

    </main>
    <h1 class="unauthorize" v-else>You are not authorized to view this page !</h1>
</template>

<script>
import { useUserStore } from 'src/stores/store-users';
import axios from 'axios';

export default {
    name: 'AdminComponent',
    setup() {
        const store = useUserStore();
        return {
            store
        }
    },

    data() {
        return {
            currentUser: this.store.user,
            isEditUserButtonSelected: false,
            users: {},
            managers: [],
            employee: [],
            user: {
                username: '',
                email: '',
                role: '',
                team_id: ''
            },
            currentUserSelected: "",
            isCreateSelected: false,
            teams: {},
        }
    },
    methods: {
        getUsers() {
            axios
                .get("/api/users")
                .then((response) => {
                    console.log(response.data.data);
                    this.users = response.data.data;
                    let retrieveAdmin = this.users.splice(0, 1);
                    console.log(retrieveAdmin);
                })
        },
        goUserShow(e) {
            axios
                .get(`/api/users/${this.currentUserSelected}`)
                .then((response) => {
                    console.log(response.data.data, "response.data.data");
                    this.currentUserSelected = e.target.value;
                    this.users = response.data.data
                    console.log(this.currentUserSelected, "current user selected");
                    this.$router.push(`/users/${this.currentUserSelected}`);
                })
        },
        handleCreateUser() {
            this.isCreateSelected = true;
        },
        getTeams() {
            axios
                .get("/api/teams")
                .then((response) => {
                    console.log(response.data.data);
                    // this.teams = response.data.data;
                })
        },
       
    },
    mounted() {
        this.getUsers();
        this.getTeams();

    }


}
</script>
<style>
.unauthorize {
    display: flex;
    justify-content: center;
    align-items: center;
    text-align: center;
    margin: 0 auto;
    border-bottom: none;
    color: red;
}

.managing_users {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    width: 90%;
}

.managing-users-head {
    display: flex;
    justify-content: space-between;
    align-items: center;
    width: 100%;
    margin-bottom: 20px;
}


.display-users {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 100%;
}

.users-table {
    width: 100%;
    font-weight: 700;
    text-align: center;
    border: 1px solid green;
}

.users-table thead {
    display: flex;
    justify-content: space-between;
    width: 100%;
    border-bottom: 1px solid green;
}

.users-table thead th {
    width: 100%;
    padding: 4px;
    text-align: center;
    color: black;
    background-color: none;
    display: flex;
    justify-content: space-around;
}

.users-table tbody {
    display: flex;
    flex-direction: column;
}

.users-table tbody .U_items {
    border-bottom: 1px solid rgb(236, 231, 231);
    width: 100%;
    padding: 4px;
    text-align: center;
    color: black;
    background-color: none;
    display: flex;
    justify-content: space-around;
}
</style>