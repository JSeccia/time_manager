<template>
  <main>
    <!-- Manager Web clocks page -->
    <section v-if="currentUser.role === 'manager'" class="manager_clock">
      <h1>Employees Clocks Trend</h1>
      <div class="search-employee-id">
        <form @submit.prevent="getAllClocksFromInput">
          <q-input rounded outlined v-model="userId" class="input_clocks" label="Employee ID" ref="userClockInput"
            color="green-10">
          </q-input>
          <q-btn class="input_btn_clocks" push color="green-10" label="Get employees last Clocks"
            @click="handleGetAllClocksFromInput" />

        </form>
      </div>

      <div class="display-employee-clocks" v-if="isGetAllClocksFromInputButtonSelected">
        <p>Details of {{ userId }}</p>
        <table>
          <thead>
            <th>Employee ID</th>
            <th>Clock Number</th>
            <th>clock status</th>
            <th>day</th>
            <th>time</th>
          </thead>
          <tbody>
            <tr v-for="clock in employeeClocks" :key="clock.id">
              <td>{{ clock.user }}</td>
              <td>{{ clock.id }}</td>
              <td>{{ clock.status }}</td>

            </tr>
          </tbody>
        </table>
        <button @click="reloadPage">
          Refresh to search other employee clocks
        </button>
      </div>
    </section>

    <!-- Employee web clocks page -->
    <section class="user_clocks">
      <div v-if="currentUser.role === 'user'" class="clock">
        <div class="title_clocks2">
          <h1>Welcome back {{ currentUser.username }}</h1>
        </div>
        <div class="clock-details">
          <input class="input_btn_clocks" type="button" value="clock in" @click.prevent="postClock">
          
          
          <table v-if="postClockSelected">
          <thead>
            <th>Clock Number</th>
            <th>clock status</th>
          </thead>
          <tbody>
            <tr v-for="clock in clocks" :key="clock.id">
              <td>{{ clock.user }}</td>
              <td>{{ clock.id }}</td>
              <td>{{ clock.status }}</td>
            </tr>
          </tbody>
        </table>
          
        </div>
      </div>
    </section>
  </main>
  <!-- date manipulate 
  <div>
    <h2 class="text-center mb-3">CLOCK</h2>
    <ul class="list-group">
      <li class="list-group-item" v-show="timestamp">
        <strong>Timestamp:</strong> {{ timestamp }}
      </li>
      <li class="list-group-item" v-show="date">
        <strong>Date:</strong> {{ date }}
      </li>
      <li class="list-group-item" v-show="time">
        <strong>Time:</strong> {{ time }}
      </li>
      <li class="list-group-item" v-show="year">
        <strong>Current Year:</strong> {{ year }}
      </li>
      <li class="list-group-item" v-show="fulldatetime">
        <strong>Full Date:</strong> {{ fulldatetime }}
      </li>
    </ul>
  </div>-->
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
      employeeToGetClocks: "",
      isGetAllClocksFromInputButtonSelected: false,

    }
  },
  methods: {
    // allow current user to clock in
    postClock() {
      axios.post(`/api/clocks/${this.currentUser.username}`);
    },
    // get current user clock times
    getClocks() {
      
      axios.get(`/api/clocks/${this.currentUser.id}`).then((response) => {
        console.log(response.data.data.length, "length");
        if (response.data.data.length > 0) {
          this.clocks = response.data.data;
          this.postClockSelected = true;
        } else {
          window.alert("No employee or clocks times found");
        }
      });
    },
    // get all clock times from one employee with its id
    getAllClocksFromInput() {
      console.log("before axios call");
      if (this.userId === "") {
        window.alert("Please enter an employee id");
        return;
      }
      axios.get(`api/clocks/${this.userId}`).then((response) => {
        console.log("during axios call");
        console.log(response.data.data.length, "length");
        if (response.data.data.length > 0) {
          this.employeeClocks = response.data.data;
          this.employeeToGetClocks = this.$refs.userClockInput.value;
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
    printDate: function () {
      return new Date().toLocaleDateString();
    },
    printTime: function () {
      return new Date().toLocaleTimeString();
    },
    printYear: function () {
      return new Date().getFullYear();
    },
    printTimestamp: function () {
      return Date.now();
    },
    printFullDate: function () {
      return new Date();
    },
    format_hours(value) {
      return moment(String(value)).format("hh:mm");
    },
    format_day(value) {
      return moment(String(value)).format("dddd");
    },
    format_date(value) {
      if (value) {
        return moment.utc(value).local().format("DD/MM/YYYY HH:mm:ss");
      }
    },
  },

  mounted: function () {
    this.date = this.printDate();
    this.time = this.printTime();
    this.timestamp = this.printTimestamp();
    this.year = this.printYear();
    this.fulldatetime = this.printFullDate();
    this.getClocks();
  },
};
</script>

<style>
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

.manager_clocks, .user_clocks {
  display: flex;
  flex-direction: column;
  align-items: center;
  height: 100%;
  width: 100%;
}

.clock {
  display: flex;
  flex-direction: column;
  align-items: center;
  height: 100%;
  width: 100%;
}

.title_clocks2 {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
}

.manager_clocks h1, .user_clocks h1 {
  text-align: center;
  border-bottom: 2px solid black;
  height: 25%;
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
  width: 100%;
}


</style>
