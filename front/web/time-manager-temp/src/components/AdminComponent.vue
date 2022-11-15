<template>
    <main class="main_profile" v-if="currentUser.role === 'admin'">
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

<style>


.q-page-container {
  height: 100vh;
  padding-top: 190px !important;
}

.q-page-container > div {
  height: 100%;
}

.main_profile {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: flex-start;
  height: 100%;
  width: 100%;
}

.profile_section {
  width: 30%;
  height: 90%;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: space-around;
  background-color: rgba(76, 175, 80, 0.14);
  box-shadow: 0 0 0 2px white;
  border-radius: 8px;
}

.avatar {
  width: 30%;
  height: 30%;
  text-align: center;
  display: flex;
  flex-direction: column;
  align-items: center;
}
.avatar span {
  font-size: 1.2rem;
  font-weight: 600;
  color: #4caf50;
}

.avatar-img {
  height: 130px;
  width: 100%;
  border-radius: 50%;
}

.profile-info {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: space-between;
  width: 50%;
  font-size: 15px;
}

.profile-info table {
  width: 100%;
  height: 100%;
  border-collapse: collapse;
  border: none;
  font-weight: 400;
  border-bottom: none;
}
.profile_table td {
  border-style: hidden;
}

#hidden {
  display: none;
}

</style> 
