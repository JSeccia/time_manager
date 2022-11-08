<template>
  <main class="main_profile">
    <div class="profile_section">
      <div class="avatar">
        <img
          class="avatar-img"
          src="../assets/images/avatar-manager.jpg"
          alt="user avatar"
        />
        <span>{{ user.username }}</span>
      </div>
      <div class="profile-info">
        <table class="profile_table">
          <tbody>
            <tr>
              <td>
                {{ user.email }}
              </td>
            </tr>
            <tr>
              <td>
                <span>Role : Manager</span>
              </td>
            </tr>
            <tr>
              <td>
                <span>Employee Numbers: {{ users.length }}</span>
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
      user: {},
      currentUser: this.store.user,
      users: []
    };
  },

  methods: {
    getUser() {
      axios.get(`/api/users/${this.currentUser.id}`).then((response) => {
        console.log(response);
        this.user = response.data.data;
      });
    },
    getUsers() {
      axios.get(`/api/users/`).then((response) => {
        console.log(response);
        this.users = response.data.data;
      });
    },
    logout(){
      localStorage.removeItem("currentUser")
      localStorage.removeItem("token")
      this.$router.push("/login")
    }
  },
  mounted: function () {
    this.getUser();
    this.getUsers();
  },
};
</script>

<style>
.main_profile {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 90vh;
}

.profile_section {
  width: 30%;
  height: 70%;
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
  height: 25%;
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
  height: 135px;
  width: 100%;
  border-radius: 50%;
}

.profile-info {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: space-between;
  width: 80%;
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
</style>
