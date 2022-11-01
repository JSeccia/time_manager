<template>
  <main>
    <div class="show-table">
      <h1> Employee Number {{ workingTime.user }}</h1>
      <table>
        <thead>
          <tr>
            <th>Number</th>
            <th>Start Time</th>
            <th>End Time</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          <tr class="WT_items">
            <td> {{ workingTime.id }}</td>
            <td :key="workingTime.start">{{ format_date(workingTime.start) }} </td>
            <td :key="workingTime.end">{{ format_date(workingTime.end) }}</td>
            <td>
              <input class="edit-button" type="button" value="update" @click="handleUpdate">
              <input class="delete-button" type="button" value="delete" @click="deleteWorkingTime">
            </td>
          </tr>
        </tbody>
      </table>
  </div>



  </main>

  <form v-if="isUpdateButtonSelected" @submit="updateWorkingTime">
    <p>Fill this form to update the working time:</p>
    <label for="start_date_input">Start Time</label>
    <input type="datetime-local" v-model="StartDate" id="start_date_input" name="start_date_input">
    <br>
    <label for="end_date_input">End Time</label>
    <input type="datetime-local" v-model="EndDate" id="end_date_input" name="end_date_input">
    <br>
    <input type="submit" id="update_working_time_submit" value="edit">
  </form>


  <br>

</template>
<!-- eslint-disable prettier/prettier -->

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
    getWorkingTime() {
      axios
        .get(`/api/working_times/${this.userId}/${this.workingTimeId}`)
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
        .put(`/api/working_times/${this.workingTimeId}`, body, {
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
          .delete(`/api/working_times/${this.workingTimeId}`)
        this.$router.go(-1);
      }
    },
    format_date(value) {
            if (value) {
                return moment(String(value)).format("MM/DD/YYYY  hh:mm");
            }
        },
  },

  mounted() {
    this.getWorkingTime();
  },
};
</script>

<style>
main {
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 100%;
  height: 100vh;
}

.show-table {
  margin-top: 100px;
  background-color: rgba(76, 175, 80, 0.2);
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 60%;
  height: 40%;
  border-radius: 8px;
  box-shadow: 0 0 8px rgba(0, 0, 0, 0.2);}

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
  background-color: #ADAF4C;
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




</style>



