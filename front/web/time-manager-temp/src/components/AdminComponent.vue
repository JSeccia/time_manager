<template>
    <main v-if="currentUser.role === 'admin'">
        <ProfileComponent/>
    </main>
    <h1 class="unauthorize" v-else>You are not authorized to view this page !</h1>
</template>

<script>
import { useUserStore } from 'src/stores/store-users';
import axios from 'axios';
import ProfileComponent from './ProfileComponent.vue';

export default {
    name: 'AdminComponent',
    components: {
    ProfileComponent,
    },
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
}
</script>
