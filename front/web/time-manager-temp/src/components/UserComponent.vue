<template>
    <main>
    <h1>User Details</h1>
    <div class="display-user-details">
        <table class="users-table">
                <thead>
                    <th>
                        <td>Id Number</td>
                        <td>Username</td>
                        <td>Email</td>
                        <td>Role</td>
                        <td>Team Group</td>
                        <td>Actions</td>
                    </th>
                </thead>
                <tbody>
                    <tr class="U_items" :key="user.id">
                        <td>{{ user.id }}</td>
                        <td>{{ user.username }}</td>
                        <td>{{ user.email }}</td>
                        <td>{{ user.role }}</td>
                        <td>{{ user.team_id }}</td>
                        <td>
                            <input
                                class="edit-button"
                                type="button"
                                value="📝"
                                @click="handleUpdate"
                            />
                            <input
                                class="delete-button"
                                type="button"
                                value="🗑"
                                @click="deleteUser"
                            />
                        </td>
                        
                    </tr>
                </tbody>
    
        </table>
    </div>


    <form id="edit-form" v-if="isEditUserButtonSelected" @submit.prevent="editUser">
        <fieldset>
            <h2 class="fs-title">Edit this User:</h2>
            <label for="username">Username</label>
            <input
            type="text"
            v-model="username"
            id="username"
            name="username"
            placeholder="User Username"
            />
            <br />
            <label for="email">Email</label>
            <input
            type="text"
            v-model="email"
            id="email"
            name="email"
            placeholder="User Email"
            />
            <label for="username">Role</label>
            <input
            type="text"
            v-model="role"
            id="role"
            name="role"
            placeholder="User Role"
            />
            <label for="username">Team Number</label>
            <input
            type="text"
            v-model="team_id"
            id="team_id"
            name="team_id"
            placeholder="User Team Id"
            />
            <label for="username">Password</label>
            <input
            type="text"
            v-model="password"
            id="team_id"
            name="team_id"
            placeholder="User password"
            />

            <br />
            <q-btn id="edit-submit" type="submit" push color="green-10" label="edit" />
        </fieldset>
    </form>
</main>
</template>

<script>
import { useUserStore } from 'src/stores/store-users';
import axios from 'axios';
import moment from 'moment';

export default {
    name: 'UserComponent',
    setup () {
        const store = useUserStore();
        return {
            store
        }
    },
    data () {
        return {
            currentUser: this.store.user,
            isEditUserButtonSelected: false,
            userId: this.$route.params.userId,
            user: {},
                username: '',
                email: '',
                role: '',
                team_id: 0,
                password: '',
        }
    },
    methods: {
        getUser() {
            console.log(this.userId);
            axios
            .get(`/api/users/${this.userId}`)
            .then((response) => {
            this.user = response.data.data;
            });
        },
        editUser() {
            console.log("Edit User button clicked");
            const body = {
                user : {
                    username: this.username,
                    email: this.email,
                    role: this.role,
                    team_id: this.team_id,
                    password: this.password,
                },
            };
            axios.put(`/api/users/${this.userId}`, body, {
                headers: {
                    "Content-Type": "application/json",
                },
            })
            .then((response) => {
                this.$router
                .push({ path: `/users/${this.userId}` })
                .then(() => { this.$router.go() })

                
            })
        },
        handleUpdate() {
            this.isEditUserButtonSelected = true;
        },
        deleteUser() {
            console.log("Delete User button clicked");
            if (confirm("Are you sure you want to delete this user?")) {
                axios.delete(`/api/users/${this.userId}`)
                .then((response) => {
                this.$router.push({ path: `/admin` })
                .then(() => { this.$router.go() })
                })
            }
            
        }
    },
    mounted() {
        this.getUser();
    },

}
</script>

<style>

.display-user-details {
    width: 70%;
    height: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    margin-top: 20px;
}



.users-table thead{
    background-color: #4CAF50;
}

</style>