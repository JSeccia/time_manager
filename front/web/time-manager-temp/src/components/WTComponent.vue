<template>
  <main>
    
    <!-- Display one working time -->

    <div class="show-table">
      <h1> Employee Number {{ workingTime.user }}</h1>
      <table>
        <thead>
          <tr>
            <th>Number</th>
            <th>Start Time</th>
            <th>End Time</th>
            <th>Total</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          <tr class="WT_items">
            <td> {{ workingTime.id }}</td>
            <td :key="workingTime.start">{{ format_date(workingTime.start) }} </td>
            <td :key="workingTime.end">{{ format_date(workingTime.end) }}</td>
            <td>
              <!-- update working time -->
              <input class="edit-button" type="button" value="📝" @click="handleUpdate">
              <!-- Delete working time -->
              <input class="delete-button" type="button" value="🗑" @click="deleteWorkingTime">
            </td>
          </tr>
        </tbody>
      </table>
    </div>
    <!-- Update Employee's Working Times -->

    <form id="edit-form" v-if="isUpdateButtonSelected" @submit="updateWorkingTime">
      <fieldset>
        <h2 class="fs-title">Edit this working time:</h2>
        <label for="start_date_input">Start Time</label>
        <input type="datetime-local" v-model="StartDate" id="start_date_input" name="start_date_input">
        <br>
        <label for="end_date_input">End Time</label>
        <input type="datetime-local" v-model="EndDate" id="end_date_input" name="end_date_input">
        <br>
        <input type="submit" id="edit-submit" value="edit">
      </fieldset>
    </form>
  </main>

  
</template>

<script>

import axios from "axios";
import moment from "moment";

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
    // Get one working time
    getWorkingTime() {
      axios
        .get(`/api/working_times/${this.userId}/${this.workingTimeId}`)
        .then((response) => {
          this.workingTime = response.data.data;
          // console.log(this.workingTime);
        });
    },
    // Handle update working time button condition
    handleUpdate() {
      console.log("Update WorkingTime button clicked");
      this.isUpdateButtonSelected = true;
    },
    // Update working time
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
        .put(`/api/working_times/${this.workingTimeId}`, body, {
          headers: {
            "Content-Type": "application/json",
          },
        })
        .then((response) => {
          // console.log(response);
          this.$router.push(`/workingtime/${this.userId}/${this.workingTimeId}`);
          this.$router.go(0);
        });
      // console.log(body);
    },
    // Delete working time
    deleteWorkingTime() {
      console.log("delete button clicked");
      if (confirm("Are you sure you want to delete this working time?")) {
        axios
          .delete(`/api/working_times/${this.workingTimeId}`)
        this.$router.go(-1);
      }
    },
    // Using moment library to retrieve the date in a readable format
    format_date(value) {
      if (value) {
          return moment(String(value)).format("MM/DD/YYYY  hh:mm");
      }
    },
    format_hours(value) {
      return moment(String(value)).format("hh:mm");
    },
    format_day(value) {
      return moment(String(value)).format("dddd");
    },
    // calculate_hours() {
    //   axios
    //     .get(`/api/working_times/${this.userId}/${this.workingTimeId}`)
    //     .then((response) => {
    //       this.workingTime = response.data.data;
    //       const w = this.workingTime;
    //       console.log(w);
    //       const end = moment(w.end).unix();
    //       console.log(end, "end");
    //       const start = moment(w.start);
    //       console.log(start, "start");
    //       // const hours = end.diff((start), "hours");
    //       // const hours = moment().duration(moment(end).diff(moment(start))).asHours();
    //       console.log(hours);
    //     });
    //   // console.log(w);
    //   // const start = moment(s);
    //   // const end = moment(e);
    //   // const end_hours = utc(e);
    //   // console.log(end_hours, "end hours");
    //   // const start_hours = moment().utc(s);
    //   // console.log(start_hours, "start hours");
    //   // const end_hours = moment().utc(this.workingTime.end);
    //   // const duration = moment.duration(end_hours.diff(start_hours));
    //   // console.log(duration);
    //   // const hours = duration.asHours();
    //   // console.log(hours);
    //   // return hours;
    // },
    // console.log(w);
      // const start = moment(s);
      // const end = moment(e);
      // const end_hours = utc(e);
      // console.log(end_hours, "end hours");
      // const start_hours = moment().utc(s);
      // console.log(start_hours, "start hours");
      // const end_hours = moment().utc(this.workingTime.end);
      // const duration = moment.duration(end_hours.diff(start_hours));
      // console.log(duration);
      // const hours = duration.asHours();
      // console.log(hours);
      // return hours;
    // calculate_TotalWorkingTime() {
    //   axios
    //     .get(`/api/working_times/${this.userId}/${this.workingTimeId}`)
    //     .then((response) => {
    //       this.workingTime = response.data.data;
    //       const w = this.workingTime;
    //       const end = moment(w.end).format("HH:mm").split(":");
    //       // console.log(end, "end");
    //       const start = moment(w.start).format("HH:mm").split(":");
    //       // console.log(start, "start");
    //       if (end[0] === "00") {
    //         end[0] = "24";
    //       }
    //       const hours = end[0] - start[0];
    //       const minutes = end[1] - start[1];

    //       console.log("prout");

    //       let totalWorkedtime = "";
    //       if (hours < 0 && minutes < 0) {
    //         let minutesTotal = 60 - parseInt(start[1]) + parseInt(end[1]);
    //         let hoursTotal = 24 - parseInt(start[0]) + parseInt(end[0]);
    //         totalWorkedtime = `${hoursTotal} hours and ${minutesTotal} minutes`;
    //       } else if (hours < 0 && minutes > 0) {
    //         let hoursTotal = 24 - parseInt(start[0]) + parseInt(end[0]);
    //         totalWorkedtime = `${hoursTotal} hours and ${minutes} minutes`;
    //       } else if (minutes < 0 && hours > 0) {
    //         let minutesTotal = 60 - parseInt(start[1]) + parseInt(end[1]);
    //         totalWorkedtime = `${hours} hours and ${minutesTotal} minutes`;
    //       } else {
    //         totalWorkedtime = `${hours} hours and ${minutes} minutes`;
    //       }
    //       console.log(totalWorkedtime);
    //       return totalWorkedtime;
    //       // const hours = end.diff((start), "hours");
    //       // const hours = moment().duration(moment(end).diff(moment(start))).asHours();
    //     });
    // },
    calculate_TotalWorkingTime() {
      axios
        .get(`/api/working_times/${this.userId}/${this.workingTimeId}`)
        .then((response) => {
          this.workingTime = response.data.data;
          const w = this.workingTime;
          const end = moment(w.end).format("HH:mm").split(":");
          // console.log(end, "end");
          const start = moment(w.start).format("HH:mm").split(":");
          // console.log(start, "start");
          if (end[0] === "00") {
            end[0] = "24";
          }
          const hours = end[0] - start[0];
          const minutes = end[1] - start[1];

          console.log("prout");

          let totalWorkedtime = "";
          if (hours < 0 && minutes < 0) {
            let minutesTotal = 60 - parseInt(start[1]) + parseInt(end[1]);
            let hoursTotal = 24 - parseInt(start[0]) + parseInt(end[0]);
            totalWorkedtime = `${hoursTotal} hours and ${minutesTotal} minutes`;
          } else if (hours < 0 && minutes > 0) {
            let hoursTotal = 24 - parseInt(start[0]) + parseInt(end[0]);
            totalWorkedtime = `${hoursTotal} hours and ${minutes} minutes`;
          } else if (minutes < 0 && hours > 0) {
            let minutesTotal = 60 - parseInt(start[1]) + parseInt(end[1]);
            totalWorkedtime = `${hours} hours and ${minutesTotal} minutes`;
          } else {
            totalWorkedtime = `${hours} hours and ${minutes} minutes`;
          }
          console.log(totalWorkedtime);
          document.querySelector(".totalWorkedTime").innerHTML = totalWorkedtime;
          // const hours = end.diff((start), "hours");
          // const hours = moment().duration(moment(end).diff(moment(start))).asHours();
        });
    },
  },
  
  // Calling get working time method when the component is created
  mounted() {
    this.getWorkingTime();
    this.calculate_TotalWorkingTime(this.workingTime);
  },
};
</script>

<style>
main {
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 100%;
}

/* Display working time details*/
.show-table {
  margin-top: 100px;
  background-color: rgba(76, 175, 80, 0.3);
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 70%;
  height: 45vh;
  border-radius: 8px;
  box-shadow: 0 0 8px rgba(0, 0, 0, 0.2);}
  .show-table h1 {
    margin-top: 20px;
    font-size: 2rem;
    font-weight: 900;
    text-shadow: -1px -1px 0px rgba(76, 175, 80, 0.2);
    color: #f5f8f5; }
  .show-table thead{
    font-weight: bolder;
    font-size: 1rem;
  }
  .show-table td{
    font-size: .8rem;
    font-weight: 500;
    color: #6d6e6e;
  }
.show-table th:nth-child(1) {
  width: 20px;}
.show-table td:nth-last-child(1) {
  display: flex;
}
.show-table td:nth-last-child(1) input {
  width: 50px;
  padding: 0;
}
.show-table td:nth-last-child(1) .delete-button {
  color: aliceblue;
  font-size: 20px;
}

h1 {
  text-align: center;
  width: 70%;
  border-radius: 10px;
  color: black;
  font-size: 24px;
  font-weight: 700;
}

.display-data {
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 100%;
  height: 100%;
}

.display-data h2 {
  font-size: 20px;
  font-weight: bold;
}

table {
  width: 80%;
  font-weight: 700;
  text-align: center;
}

table th {
  padding: 4px;
  text-align: center;
  color: black;
  background-color: none;
}

tbody tr {
  border-bottom: 1px solid rgb(236, 231, 231);
  margin: 0 50px;
}

.edit-button, .delete-button {
  display: inline-block;
  outline: 0;
  border: none;
  cursor: pointer;
  font-weight: 600;
  border-radius: 4px;
  font-size: 13px;
  height: 30px;
  color: white;
  padding: 0 20px;
}

.edit-button {
  background-color: #6ccd6f;
  margin-right: 10px;
  color: #62632b;

}
.edit-button:hover {
  background-color: #adaf4cc0;
}

.delete-button {
  background-color: #EB5757;
  color: darkred;
}

.delete-button:hover {
  background-color: #eb575793;
}

/* Update form */

#edit-form {
        width: 400px;
        margin: 50px auto;
        text-align: center;
        position: relative;
    }
    #edit-form h2 {
        font-size: 20px;
        font-weight: bold;
    } 

    #edit-form fieldset {
        background: white;
        border: 0 none;
        border-radius: 3px;
        box-shadow: 0 0 15px 1px rgba(0, 0, 0, 0.4);
        padding: 20px 30px;
        box-sizing: border-box;
        width: 80%;
        margin: 0 10%;
    }

    #edit-form input {
        padding: 15px;
        border: 1px solid #ccc;
        border-radius: 3px;
        margin-bottom: 10px;
        width: 100%;
        box-sizing: border-box;
        font-family: montserrat;
        color: #2C3E50;
        font-size: 13px;
    }
    #edit-form #edit-submit {
        width: 100px;
        background: #27AE60;
        font-weight: bold;
        color: white;
        border: 0 none;
        border-radius: 1px;
        cursor: pointer;
        padding: 10px 5px;
        margin: 10px 5px;
    }
    #edit-form #edit-submit:hover, #edit-form #edit-submit:focus {
        box-shadow: 0 0 0 2px white, 0 0 0 3px #27AE60;
    }



</style>



