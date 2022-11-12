<template>
    <main v-if="currentUser.role === 'admin'">
        <h1>Manage Users</h1>
        <section class="managing_users">

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
                                <input type="button" class="select_user" :value="user.id" @click.prevent="goUserShow" />
                            </td>
                            <td>{{ user.username }}</td>
                            <td>{{ user.email }}</td>
                            <td>{{ user.role }}</td>
                            <td>{{ user.team_id }}</td>
                            
                        </tr>
                    </tbody>

                </table>
            </div>
        </section>
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
    },
    mounted() {
        this.getUsers();
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
}

.users-table thead {
    display: flex;
    justify-content: space-around;
    width: 100%;
    border: 1px solid green;
}

.users-table thead th {
    width:100%;
    color: black;
    background-color: none;
    display: flex;
    justify-content: space-around;
    background-color: #4caf50;

}

.users-table tbody {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    border: 1px solid green;
    width: 100%;
}

.users-table tbody .U_items {
    width: 100%;
    padding: 4px;
    color: black;
    background-color: none;
    display: flex;
    justify-content: space-around;
}

.users-table tbody .U_items td {
    width: 10%;
    display: flex;
    justify-content: center;
    align-items: center;
}

.select_user {
    border: none;
    background-color: transparent;
}

.select_user:hover {
  color: #4caf50;
  border-color: #4caf50;
  text-decoration: none;
}
</style>