<template>
  <p id="hidden">&#x1F5D8;</p> 
  <main class="main_profile">
    <div class="profile_section">
      <div class="avatar">
        <img
          class="avatar-img"
          src="../assets/images/avatar-manager.jpg"
          alt="user avatar"
        />
        <span> {{ currentUser.username }}</span>
      </div>
      <div class="profile-info">
        <table class="profile_table">
          <tbody>
            <tr>
              <td>
                email: {{ currentUser.email }}
              </td>
            </tr>
            <tr>
              <td>
                <span>Role: {{ currentUser.role }}</span>
              </td>
            </tr>
            <tr>
              <td>
                <span v-if="this.currentUser.role === 'user'"> Team n°{{ user.team_id }}</span>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
      <div class="logout-button">
        <q-btn push color="green-10" label="Logout" @click="logout" />
      </div>
    </div>
  </main>
</template>

<script>
import axios from "axios";
import { useUserStore } from "src/stores/store-users";
export default {
  name: "ProfileComponent",
  setup() {
    const store = useUserStore();
    return {
      store,
    };
  },
  data() {
    return {
      currentUser: this.store.user,
      users: [],
      user: {},
    };
  },

  methods: {
    getUsers() {
      axios.get(`/api/users/`).then((response) => {
        this.users = response.data.data;
      });
    },

    getUserTeam() {
      axios.get(`/api/users/${this.currentUser.id}`).then((response) => {
        this.user = response.data.data;
      });
    },
    
    logout() {
      localStorage.removeItem("currenUser", this.user);
      localStorage.removeItem("currentUser");
      localStorage.removeItem("token");
      localStorage.clear();
      this.$router
          .push({ path: '/login' })
          .then(() => { this.$router.go() })
      
    },
  },
  mounted: function () {
    this.getUsers();
    this.getUserTeam();
  },
};
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

@media only screen and (min-width: 780px) and (max-width: 820px) {
  .q-page-container > div {
    height: 50%;
  }

  .q-page-container .main_profile {
    height: 85%;
  }
  
  .profile_section {
    width: 50%;
  }
}

</style>
