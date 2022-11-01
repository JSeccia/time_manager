<template>
  <div class="q-pa-md">
    <div class="q-gutter-md">
      <q-time v-model="time" />

      <q-time v-model="timeWithSeconds" with-seconds />
    </div>
  </div>

  <main>
    <div class="text1">
      <p>Clock template</p>
    </div>
  </main>
  <div class="workingtimes">
    <button @click="$router.push('/workingtimes')">
      Click to go on WorkingTimes
    </button>
  </div>
  <div class="chart">
    <button @click="$router.push('/chart')">Click to go to Chart</button>
  </div>
  <div class="home">
    <button @click="$router.push('/')">Click to go to Home</button>
  </div>
  <br /><br />

  <div class="clock">
    <form @submit="getClock">
      <label for="get_user_clock" placeholder="enter employee id"></label>
      <input
        type="text"
        id="get_user_clock"
        v-model="userId"
        placeholder="enter employee id"
        ref="userIdInput"
      />
      <input type="submit" value="click to display clock" />
    </form>

    <!-- Display clock start userId-->
    <!--
        <form @submit="getClock">
            <label for="get_user_clock" placeholder="enter start clock"></label>
            <input
            type="text"
            id="get_user_clock"
            v-model="userId"
            placeholder="enter start clock"
            ref="userIdInput"
            />
            <input type="submit" value="click to start clock" />
        </form>


         Display clock end userId-- >  
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
        </form> 
    -->
  </div>
  <br />
  <h2>Employee {{ currentUserId }} CLOCK Times:</h2>

  <ul class="WT_item" v-for="item in clock" :key="item.id">
    <p>Working Times number {{ item.id }}</p>
    <li>Start work time: {{ item.status }}</li>
    <li>End work time:{{ item.time }}</li>
    <br />
  </ul>

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
  </div>
</template>

<script>
import { ref } from "vue";
import axios from "axios";

export default {
  setup() {
    return {
      timee: ref("10:56"),
      timeWithSeconds: ref("09:24:10"),
    };
  },

  data() {
    return {
      Clock: {
        // userId: 0,
      },
      currentUserId: "",
    };
  },

  // afficher clock userId,
  methods: {
    getClock(submitNumber) {
      submitNumber.preventDefault();

      if (this.userId === "") {
        window.alert("Please enter an employee id");
        return;
      }
      axios.get(`/api/clocks/${this.userId}`).then((response) => {
        if (response.data.data.length > 0) {
          this.clock = response.data.data;
          this.currentUserId = this.$refs.userIdInput.value;
        } else {
          window.alert("No employer or clocks times found");
        }
      });
    },
  },

  name: "DateComponent",
  data: () => ({
    date: "",
    time: "",
    year: "",
    timestamp: "",
    fulldatetime: "",
  }),
  methods: {
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
