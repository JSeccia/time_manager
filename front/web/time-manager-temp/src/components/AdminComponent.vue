<template>
    <h1>Admin Dashboard Page</h1>
    <div class="managing_users">
        {{users}}
    </div>

    <div class="managing_teams">

    </div>  

    <div class="managing_managers">

    </div>


</template>

<script>
import { useUserStore } from 'src/stores/store-users'; 
import axios from 'axios';

export default {
    name: 'AdminComponent',
    setup () {
        const store = useUserStore();
        return {
            store
        }
    },

    data () {
        return {
            currentUser: this.store.user,

            users: {},
            teams: [],
            managers: [],
            employee: [],
        }
    },
    methods: {
        getUsers() {
            if (this.currentUser.role === "admin") {
                axios
                .get(`api/users`)
                .then((response) => {
                    console.log(response.data.data);
                    this.users = response.data.data;
                    console.log(this.users);
                    return this.users;
                })
            } else {
                window.alert("You are not an admin");
            }
        }
    },

}
</script>