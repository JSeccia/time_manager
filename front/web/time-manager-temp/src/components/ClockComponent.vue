<template>
  <main>

    <!-- Manager Web clocks page -->
    <section class="section_clocks">
      <h1 class="title_clocks">Employees Clocks Trend</h1>
      <div class="search-employee-id">
        <form @submit.prevent="getAllClocksFromInput">
          <q-input rounded outlined v-model="userId" class="input_clocks" label="Employee ID" ref="userClockInput"
            color="green-10">
          </q-input>
          <q-btn class="input_btn_clocks" push color="green-10" label="Get employees last Clocks" @click="handleGetAllClocksFromInput" />
         
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
  </main>

  <div class="clock">

    <!-- Employee web clocks page -->

    <div class="q-pa-md">
      <div class="q-gutter-md">
        <q-time v-model="clockIn" with-seconds />
      </div>
    </div>


    <h1>Welcome back, {{currentUser.username}}</h1>
    <input type="button" value="click to clock in" @click.prevent="postClock">

    <button @click="getClocks">
        See your clock details:
    </button>
    <ul>
      <li>{{currentUser.username}}</li>
    </ul>
  </div>
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

export default {
  setup() {
    return {
      clockIn: ref("10:56"),
    };
  },

  name: "DateComponent",
  data: () => ({
    currentUser: localStorage.getItem("currentUser")
      ? JSON.parse(localStorage.getItem("currentUser"))
      : {
        email: "",
        username: "",
        id: 0,
      },
    date: "",
    time: "",
    year: "",
    timestamp: "",
    fulldatetime: "",
    // manager get all clocks from one employee id
    employeeClocks: {},
    employeeToGetClocks: "",
    isGetAllClocksFromInputButtonSelected: false,
  }),
  methods: {
    // allow current user to clock in
    postClock() {
      axios.post(`/api/clocks/${this.currentUser.username}`);
    },
    // get current user clock times
    getClocks(event) {
      event.preventDefault();

      if (this.userId === "") {
        window.alert("Please enter an employee id");
        return;
      }
      axios.get(`/api/clocks/${this.currentUser.id}`).then((response) => {
        console.log(response.data.data.length, "length");
        if (response.data.data.length > 0) {
          this.clocks = response.data.data;
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

.section_clocks {
  display: flex;
  flex-direction: column;
  align-items: center;
  height: 100vh;
  width: 85%;
  border: 1px solid red;
}

.title_clocks {
  font-size: 25px;
  font-weight: bold;
  border-bottom: 2px solid black;
  height: 10%;
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
