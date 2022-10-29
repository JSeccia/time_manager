<!-- eslint-disable prettier/prettier -->
<template>
    
    <ul>
        <li>Number : {{workingTime.id}}</li>
        <li>start work :{{workingTime.start}}</li>
        <li>end work : {{workingTime.end}}</li>
    </ul>
    <button>Update</button>
    <button>Delete</button>



   
    
    <br>

</template>

<script>
import axios from "axios";
// import moment from "moment";
export default {
  name: "WorkingTime",
  data() {
    return {
      workingTime: {},
      userId: this.$route.params.userId,
      workingTimeId: this.$route.params.id,
    };
  },

  methods: {
    getWorkingTime() {
      axios
        .get(`http://192.168.75.113:4000/api/working_times/${this.userId}/${this.workingTimeId}`)
        .then((response) => {
          this.workingTime = response.data.data;
          console.log(this.workingTime);
        });
    },
  },
  mounted() {
    this.getWorkingTime();
  },
};
</script>

