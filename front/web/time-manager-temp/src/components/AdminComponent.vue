<template>
    <main v-if="currentUser.role === 'admin'">
    <h1>Admin Dashboard Page</h1>
    <div class="managing_users">
        {{users}}
    </div>

    <div class="managing_teams">

    </div>  

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
</style>