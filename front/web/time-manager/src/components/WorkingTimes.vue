

<template>
  <h1>Check employee's working times</h1>
  <br>
  <form @submit="getWorkingTimes">
    <label for="get_user_working_times" placeholder="enter employee id"></label>
    <input
      type="text"
      id="get_user_working_times"
      v-model="userId"
      placeholder="enter employee id"
      ref="userIdInput"
    />
    <input type="submit" value="Get working times" />
  </form>
  <br>
  <h2>Employee {{ currentUserId }} Working Times:</h2>
  <ul class="WT_item" v-for="item in workingTimes" :key="item.id">
    <p>Working Times number {{ item.id }}</p>
    <input type="button" :value="item.id" @click="goWorkingTime">
    <!-- <RouterLink :to="{ name: 'WorkingTime', params: { id: item.id }}">workingTime</RouterLink>-->


    <li>Start work time: {{ item.start }}</li>
    <li>End work time:{{ item.end }}</li>
    <br>
  </ul>
  <br>

</template>

<script>
import axios from "axios";


export default {
  name: "WorkingTimes",
  data() {

    return {
      workingTimes: {},
      currentUserId: "",
      currentWorkingTimeId: "",
    };
  },

  methods: {
    getWorkingTimes(submitNumber) {
      submitNumber.preventDefault();

      if (this.userId === "") {
        window.alert("Please enter an employee id");
        return;
      }
      axios
        .get(`http://192.168.69.190:4000/api/working_times/${this.userId}`)
        .then((response) => {
          if (response.data.data.length > 0) {
            this.workingTimes = response.data.data;
            this.currentUserId = this.$refs.userIdInput.value;
          } else {
            window.alert("No employee or working times found");
          }
        });
    },

    goWorkingTime(e) {
      axios
        .get(`http://192.168.69.190:4000/api/working_times/${this.userId}`)
        .then((response) => {
          if (response.data.data.length > 0) {
            this.workingTimes = response.data.data;
            this.currentWorkingTimeId = e.target.value;
            console.log(`current workingtime id : ${this.currentWorkingTimeId}`);
            this.$router.push(
              `/workingtimes/${this.currentUserId}/${this.currentWorkingTimeId}`
            );
          }
        });
    },
  },
  };
</script>
