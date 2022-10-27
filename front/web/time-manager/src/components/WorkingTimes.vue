<template>
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
    <li>Start work time: {{ item.start }}</li>
    <li>End work time:{{ item.end }}</li>
    <br>
  </ul>

</template>

<script>
import axios from "axios";

export default {
  name: "WorkingTimes",
  data() {

    return {
      workingTimes: {
        // userId: 0,
      },
      currentUserId: "",
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
        .get(`http://192.168.76.161:4000/api/working_times/${this.userId}`)
        .then((response) => {
          if (response.data.data.length > 0) {
            this.workingTimes = response.data.data;
            this.currentUserId = this.$refs.userIdInput.value;
          } else {
            window.alert("No employer or working times found");
          }
        });
    },
  },
};
</script>
