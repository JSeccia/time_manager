<template>

  <main>
    <section class="section-clocks">
      <h1>See your employees last clock times:</h1>
      <div class="search-employee-id">

        <form @submit="getAllClocksFromInput">
          <label for="get_this_employee_clocks"></label>
          <input type="text" id="get_this_employee_clocks" v-model="userId" placeholder="enter employee id"
            ref="userIdInput" />
          <input type="submit" value="Get Employee last clocks" @click="handleGetAllClocksFromInput" />
        </form>

      </div>

      <div class="display-employee-clocks" v-if="isGetAllClocksFromInputButtonSelected">
        <p>Details of {{ userId }}</p>
        <table>
          <theader>
            <th>Employee ID</th>
            <th>Clock Number</th>
            <th>clock status</th>
            <th>clock time</th>
          </theader>
          <tbody>
            <tr v-for="clock in employeeClocks" :key="clock.id">
              <td>{{ clock.user }}</td>
              <td>{{ clock.id }}</td>
              <td>{{ clock.status }}</td>
              <td>{{ format_date(clock.time) }}</td>
            </tr>
          </tbody>
        </table>
      </div>
    </section>


    <p>------------------------------------------------------------------------------------------</p>

    GRAPH DES WORKING TIMES DE TOUS LES USERS SUR UNE semaine

    1) array avec les 7 jours de la semaine
    2) méthode qui détermine le jour d'aujourd'hui
    
    3) méthode qui permet de récupérer les wt d'un user et directement de les convertir dans un array jour et un array heure 
    4) méthode qui permet de convertir le temps de travail en heures et l'extraire

    prendre un temps de travail et créer méthode pour soustraire end - start
    3) calculer le temps de travail d'un utilisateur sur un jour
    4) calculer le temps de travail d'un utilisateur sur une semaine

     




    <p>------------------------------------------------------------------------------------------</p>


    <!-- clock time interactive-->

    <!-- <div class="q-pa-md">
    <div class="q-gutter-md">
      <q-time v-model="time" />

      <q-time v-model="timeWithSeconds" with-seconds />
    </div>
  </div>
  -->

    <!--<button @click="getClocks">
        Get clocks from employee: {{ currentUser.id }}
      </button>-->


    <!-- <p>display clock details of current user {{userId}}</p>
      <ul v-for="item in clocks" :key="item.id">
        <li>Clock n°: {{ item.id }}</li>
        <li>Clocked in: {{ item.status }}</li>
        <li>Clock time: {{ format_date(item.time) }}</li>
        <br />
      </ul> -->


    <!-- Display clock start ofuserId

    <p>Your id number: {{ currentUser.id }}</p>
    <p>Your username: {{ currentUser.username }} </p>
    <p>Your CLOCK Times:</p>
    -->


    <br>
    <!-- <p>button to see working times of one user for manager</p>
      <div class="workingtimes">
        <button @click="$router.push('/workingtimes')">
          Click to go on WorkingTimes
        </button>
      </div> -->

  </main>

  <!-- others codes test 
  <div class="chart">
    <button @click="$router.push('/chart')">Click to go to Chart</button>
  </div>
  <div class="home">
    <button @click="$router.push('/')">Click to go to Home</button>
  </div>
  -->

  <div class="clock">
    <!-- <form @submit="getClocks">
      <label for="get_user_clock" placeholder="enter employee id"></label>
      <input
        type="text"
        id="get_user_clock"
        v-model="userId"
        placeholder="enter employee id"
        ref="userIdInput"
      />
      <input type="submit" value="click to display clock" />
    </form> -->




    Template for one employee logged in
    <button @click="postClock">Click to clock in or out</button>


    <p>Your id number: {{ currentUser.id }}</p>
    <p>Your username: {{ currentUser.username }} </p>
    



    <!-- Display clock end userId-- >  
        <form @submit="getClock">
            <label for="get_user_clock" placeholder="enter end clock"></label>
            <input
            type="text"
            id="get_user_clock"
            v-model="userId"
            placeholder="enter end clock"
            ref="userIdInput"
            />
            <input type="submit" value="click to end clock" />
        </form>  -->
  </div>
  <br />
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
      timee: ref("10:56"),
      timeWithSeconds: ref("09:24:10"),
    };
  },

  name: "DateComponent",
  data: () => ({
    clocks: [],
    currentUser: JSON.parse(localStorage.getItem("currentUser")),
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
      axios
        .get(`/api/clocks/${this.currentUser.id}`)
        .then((response) => {
          console.log(response.data.data.length, "length");
          if (response.data.data.length > 0) {
            this.clocks = response.data.data;
          } else {
            window.alert("No employee or clocks times found");
          }
        });
    },
    // get all clock times from one employee with its id 
    getAllClocksFromInput(e) {
      e.preventDefault()
      console.log("before axios call")
      if (this.userId === "") {
        window.alert("Please enter an employee id");
        return;
      }
      axios
        .get(`api/clocks/${this.userId}`)
        .then((response) => {
          console.log("during axios call");
          console.log(response.data.data.length, "length");
          if (response.data.data.length > 0) {
            this.employeeClocks = response.data.data;
            this.employeeToGetClocks = this.$refs.userIdInput.value;
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
</style>