<!-- eslint-disable prettier/prettier -->

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
    
    <br>
  </ul>
  <br>
  <input type="button" value="Add more working times" @click="handleAddWorkingTime">
  <br>

  
  <form v-if="isAddButtonSelected" @submit="createWorkingTime">
      <label for="start_date_input">Start Time</label>
      <input type="datetime-local" v-model="CreateStartDate" id="start_date_input" name="start_date_input">
      <br>
      <label for="end_date_input">End Time</label>
      <input type="datetime-local" v-model="CreateEndDate" id="end_date_input" name="end_date_input">
      <br>
      <input type="submit" id="create_working_time_submit" value="Create">
  </form>



</template>

<!-- eslint-disable prettier/prettier -->


<script>
import axios from "axios";


// creer un addWorkingTime Button:
// ce button renvoie vers la method addWorkingTime
// créer un formulaire qui se display avec un input start et un input end
// recuperer le current user 
// récuperer les valeurs du start et du end
// et les ajouter au tableau working times du current user
// retourner le nouveau working time d'abord sur la page



export default {
  name: "WorkingTimes",
  data() {

    return {
      workingTimes: {},
      currentUserId: "",
      currentWorkingTimeId: "",
      form: {
        CreateStartDate: new Date().toLocaleString(),
        CreateEndDate: new Date().toLocaleString(),
      },
      isAddButtonSelected: false,
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
        .get(`http://192.168.75.113:4000/api/working_times/${this.userId}`)
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
        .get(`http://192.168.75.113:4000/api/working_times/${this.userId}`)
        .then((response) => {
          if (response.data.data.length > 0) {
            this.workingTimes = response.data.data;
            this.currentWorkingTimeId = e.target.value;
            console.log(`current workingtime id : ${this.currentWorkingTimeId}`);
            this.$router.push(
              `/workingtime/${this.currentUserId}/${this.currentWorkingTimeId}`
            );
          }
        });
    },
    handleAddWorkingTime() {
      console.log("add WorkingTime button clicked");
      this.isAddButtonSelected = true;
    },
    createWorkingTime(e) {
      e.preventDefault();
      console.log("create submit button clicked");
      if (this.userId === "") {
        window.alert("Please enter an employee id");
        return;
      }
      const body = {
        working_time: {
          start: this.CreateStartDate,
          end: this.CreateEndDate,
          // user: this.currentUserId,
        },
      };
      axios
      .post(`http://192.168.75.113:4000/api/working_times/${this.userId}`, body, {
        headers: {
          "Content-Type": "application/json",
        },
      })
      .then((response) => {
        console.log(response);
      });
     console.log(body);
    }
  },
  };
</script>
