<template>
    yoooo

    show user details 
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
                            @click="DeleteUser"
                        />
                    </td>
                    
                </tr>
            </tbody>

        </table>


        <form id="edit-form" v-if="isEditUserButtonSelected" @submit="EditUser">
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
                <input
                type="text"
                v-model="team_id"
                id="team_id"
                name="team_id"
                placeholder="User Team Id"
                />

                <br />
                <q-btn id="edit-submit" type="submit" push color="green-10" label="edit" />
            </fieldset>
        </form>

</template>

<script>
import { useUserStore } from 'src/stores/store-users';
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
            user: {},
            form: {
                username: '',
                email: '',
                role: '',
                team_id: '',
            },
        }
    },
    methods: {
        // getUser() {
            
        // },

        

        // EditUser(e) {
        //     e.preventDefault();
        //     console.log("Edit User button clicked");
        //     const body = {
        //         user : {
        //             id: this.id,
        //             username: this.username,
        //             email: this.email,
        //             role: this.role,
        //             team_id: this.team_id,
        //         },
        //     };
        //     axios.get(`/api/users/${this.user_id}`, body, {
        //         headers: {
        //             "Content-Type": "application/json",
        //         },
        //     })
        //     .then((response) => {
        //         console.log(response.data);
        //         this.$router
        //         .push({ path: '/admin' })
        //         .then(() => { this.$router.go() })
        //     })
        // },
    }

}
</script>