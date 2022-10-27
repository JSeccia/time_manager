<template>
    <form @submit="getWorkingTimes">
    <input type="text" id="get_user_working_times" v-model="userId" />
    <label for="get_user_working_times" placeholder="enter employee id"></label>
    <input type="submit" value="Get user working times" />
  </form>
  <ul class="item" v-for="item in workingTimes" :key="item.id">
        <li>{{item.id}}</li>
        <li>{{item.userId}}</li>
        <li>{{item.start}}</li>
        <li>{{item.end}}</li>
      </ul>
   
  </template>

<script>
  import axios from "axios";

  export default {
    name: "WorkingTimes",
    data()
    {
      return {
        workingTimes: {
          start: "",
          end: "",
        },
      };
    },
    methods: {
      getWorkingTimes(e) {
        e.preventDefault();
        if (this.userID === null) {
          window.alert("no id");
          return;
        }
        axios
        .get(`http://192.168.76.161:4000/api/working_times/${this.userId}`)
        .then((response) => {
            // localStorage.setItem("currentUserWT", JSON.stringify(response.data.data));
            console.log(response.data)
            this.workingTimes = response.data.data;
        })
      },
    }, 
  }
  
</script>