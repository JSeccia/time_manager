<!-- eslint-disable prettier/prettier -->
<template>
    
    <ul>
        <li>Number : {{workingTime.id}}</li>
        <li :key="workingTime.start">start work :{{workingTime.start}}</li>
        <li :key="workingTime.end"> end work : {{workingTime.end}}</li>
    </ul>
    <input type="button" value="update" @click="handleUpdate">
    <input type="button" value="delete" @click="deleteWorkingTime">

    <form v-if="isUpdateButtonSelected" @submit="updateWorkingTime">
      <p>Fill this form to update the working time:</p>
      <label for="start_date_input">Start Time</label>
      <input type="datetime-local" v-model="StartDate" id="start_date_input" name="start_date_input">
      <br>
      <label for="end_date_input">End Time</label>
      <input type="datetime-local" v-model="EndDate" id="end_date_input" name="end_date_input">
      <br>
      <input type="submit" id="update_working_time_submit" value="edit" >
    </form>
   
    
    <br>

</template>
<!-- eslint-disable prettier/prettier -->

<script>

import axios from "axios";
// import moment from "moment";
export default {
  name: "WTComponent",
  data() {
    return {
      workingTime: {},
      userId: this.$route.params.userId,
      workingTimeId: this.$route.params.id,
      isUpdateButtonSelected: false,
      form: {
        StartDate: new Date().toLocaleString(),
        EndDate: new Date().toLocaleString(),
      },
    };
  },

  methods: {
    getWorkingTime() {
      axios
        .get(`http://192.168.73.197:4000/api/working_times/${this.userId}/${this.workingTimeId}`)
        .then((response) => {
          this.workingTime = response.data.data;
          console.log(this.workingTime);
        });
    },
    handleUpdate() {
      console.log("Update WorkingTime button clicked");
      this.isUpdateButtonSelected = true;
    },
    updateWorkingTime(e) {
      e.preventDefault();
      console.log("update button clicked");
      
      const body = {
        working_time: {
            user: this.workingTime.user,
            start: this.StartDate ?? null,
            end: this.EndDate ?? null,
        },
      }
      axios
        .put(`http://192.168.73.197:4000/api/working_times/${this.workingTimeId}`, body, {
          headers: {
            "Content-Type": "application/json",
          },
        })
        .then((response) => {
          console.log(response);
          this.$router.push(`/workingtime/${this.userId}/${this.workingTimeId}`);
          this.$router.go(0);
        });
        console.log(body);    
    },
    deleteWorkingTime() {
      console.log("delete button clicked");
      if (confirm("Are you sure you want to delete this working time?")) {
        axios
          .delete(`http://192.168.73.197:4000/api/working_times/${this.workingTimeId}`)
          this.$router.go(-1);
      }
    },
  },
  
  mounted() {
    this.getWorkingTime();
  },
};
</script>

