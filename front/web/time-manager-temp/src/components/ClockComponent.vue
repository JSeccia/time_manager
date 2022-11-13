<template>
  <main class="main-manager-clocks">
    <!-- Manager Web clocks page -->
    <section v-if="currentUser.role === 'manager' || currentUser.role === 'admin'" class="manager_clock">
      <h1>Team last Clocks</h1>
      <div class="search-employee-id">
        <form @submit.prevent="getAllClocksFromInput">
          <q-input rounded outlined v-model="userId" class="search_wt_input" placeholder="enter team member id"
          ref="userClockInput" id="get_user_clocks" color="green-10">
          </q-input>
          
          <q-btn class="search_wt_btn" push color="green-10" label="get team last Clocks"
            @click="handleGetAllClocksFromInput" />

        </form>
      </div>

      <div class="display-clocks" v-if="isGetAllClocksFromInputButtonSelected">
        <h2>Details of Team user {{ userId }}:</h2>
        <table class="users-table">
          <thead>
            <th>Employee ID</th>
            <th>Clock Number</th>
            <th>clock status</th>
            <th>clock time</th>
          </thead>
          <tbody>
            <tr class="U_items" v-for="clock in employeeClocks" :key="clock.id">
              <td>{{ clock.user }}</td>
              <td>{{ clock.id }}</td>
              <td>{{ clock.status }}</td>
              <td>{{ format_date(clock.time) }}</td>
            </tr>
          </tbody>
        </table>
        
        
      </div>
    </section>

    <!-- Employee web clocks page -->
    <section class="user_clocks">
      <div v-if="currentUser.role === 'user'" class="clock">
        <div class="title_clocks2">
          <h1>Welcome back {{ upperCaseUsername }},</h1>
        </div>
        <q-btn v-if="!postClockSelected" class="input_btn_clocks" type="button" label="clock in"
          @click.prevent="postClock" push color="green 10" />
        <q-btn v-else class="input_btn_clocks" type="button" label="clock out" @click.prevent="postClock" push
          color="green 10" />
        <div v-if="postClock" class="display-clocks">



          <table class="users-table">
            <thead>
              <th>Clock Number</th>
              <th>Clock Status</th>
              <th>Day Time</th>
            </thead>
            <tbody>
              <tr class="U_items" v-for="clock in clocks" :key="clock.id">
                <td>{{ clock.id }}</td>
                <td>{{ clock.status }}</td>
                <td>{{ format_date(clock.time) }}</td>
              </tr>
            </tbody>
          </table>

        </div>
      </div>
    </section>
  </main>
</template>

<script>
import { ref } from "vue";
import axios from "axios";
import moment from "moment";
import { useUserStore } from "src/stores/store-users";

export default {
  setup() {
    const store = useUserStore();
    return {
      store,
    };
  },

  name: "ClockComponent",
  data() {
    return {
      currentUser: this.store.user,
      date: "",
      time: "",
      year: "",
      timestamp: "",
      fulldatetime: "",
      clocks: [],
      postClockSelected: false,
      // manager get all clocks from one employee id
      employeeClocks: {},
      currentUserId: "",
      isGetAllClocksFromInputButtonSelected: false,
      clockInBtn: false,


    }
  },
  computed: {
    upperCaseUsername() {
      const username = this.currentUser.username;
      const upperCaseUsername = username.charAt(0).toUpperCase() + username.slice(1);
      return upperCaseUsername;
    },
  },
  methods: {
    // allow current user to clock in
    postClock() {
      axios.post(`/api/clocks/${this.currentUser.username}`)
        .then((response) => {
          if(response.data) {
            this.postClockSelected = true;
            this.clocks = response.data;
            console.log("1", this.clocks);
          } else {
            this.postClockSelected = false;
            this.clocks = response.data;
            console.log("2nd if statement", this.clocks);

          } 
          
        }) 
        .catch((error) => {
          console.log(error);
        });
    },
    // get current user clock times
    getClocks() {

      axios.get(`/api/clocks/${this.currentUser.id}`).then((response) => {
        console.log(response.data.data.length, "length");
        if (response.data.data.length > 0) {
          this.clocks = response.data.data;
          this.postClockSelected = true;
        } 
      });
    },
    // get all clock times from one employee with its id
    getAllClocksFromInput() {
      console.log("before axios call");
      // if (this.userId.team_id != this.currentUser.team_id) {
      //   window.alert("Please enter a team id valid");
      //   return;
      // }
      axios.get(`api/clocks/${this.userId}`).then((response) => {
        console.log("during axios call");
        console.log(response.data.data, "response.data.data");
        if (response.data.data.length > 0) {
          this.employeeClocks = response.data.data;
          this.currentUserId = this.$refs.userClockInput.value;
          console.log(this.employeeClocks, "employeeClocks");
        } else {
          window.alert("No employee or clocks times found");
        }
      });
    },
    // handle gacfi button click
    handleGetAllClocksFromInput() {
      this.isGetAllClocksFromInputButtonSelected = true;
    },
    reloadPage() {
      window.location.reload();
    },


    // manipulate date
    format_hours(value) {
      return moment(String(value)).format("hh:mm");
    },
    format_day(value) {
      return moment(String(value)).format("dddd");
    },
    format_date(value) {
      if (value) {
        return moment(value).local().format("DD/MM/YYYY HH:mm:ss");
      }
    },
  },

  mounted: function () {
    this.getClocks();
  },
};
</script>

<style>

.main-manager-clocks {
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
  width: 100%;
  height: 100vh
  

}
.manager_clock,
.user_clocks {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: space-around;
  height: 60%;
  width: 100%;
}

.manager_clock h1 {
  width: 35%;
  height: 18%;
}

.manager_clock .search-employee-id {
  width: 36%;
  height: 33%;
  display: flex;
  justify-content: center;
  align-items: center;
  
}

.manager_clock .search-employee-id form {
  width: 100%;
  height: 100%;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.manager_clock .search-employee-id form .search_wt_input {
  width: 46%;
  border: none;
  height: 35%;
}

.manager_clock .search-employee-id form .search_wt_btn {
  width: 52%;
  display: flex;
  align-items: center;
  height: 35%;
}
 

.clock {
  display: flex;
  flex-direction: column;
  align-items: center;
  height: 100%;
  width: 40%;
}

.title_clocks2 {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
}


table {
  width: 100%;
  font-weight: 700;
  text-align: center;
}

table th {
  padding: 4px;
  text-align: center;
  color: black;
  background-color: none;
  width: 30%;
}

tbody tr {
  border-bottom: 1px solid rgb(236, 231, 231);
  margin: 0 50px;
}

.display-clocks {
  display: flex;
  flex-direction: column;
  align-items: center;
  height: 5%;
  width: 60%;
}

.display-clocks h2 {
  font-size: 20px;
  color: black;
  font-weight: 700;
}

.display-clocks .users-table thead th {
  color: #fff;
}




.input_clocks {
  margin: 3%;
  width: 100%;
  border: 1px solid yellow;
  height: 15%;
}

.input_btn_clocks {
  margin: 3%;
  height: 10%;
  width: 40%;
}
</style>
