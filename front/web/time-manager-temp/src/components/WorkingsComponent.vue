<template>
  <main>
    <h1>Check employee's working times</h1>

    <ul :key="currentUser.id">
      <li>{{ currentUser.id }}</li>
      <li>{{ currentUser.username }}</li>
      <li>{{ currentUser.email }}</li>
    </ul>
    <!-- Search Employee Id form -->

    <section class="search-id">
      <form @submit="getWorkingTimes">
        <label
          for="get_user_working_times"
          placeholder="enter employee id"
        ></label>
        <input
          type="text"
          id="get_user_working_times"
          v-model="userId"
          placeholder="enter employee id"
          ref="userIdInput"
        />
        <input type="submit" value="Get working times" />
      </form>
      <input
        id="add-button"
        type="button"
        value="Add working times"
        @click="handleAddWorkingTime"
      />
    </section>

    <!-- Display Employee's Working Times from its ID -->

    <section class="display-data">
      <h2>Employee n° {{ currentUserId }} Working Times:</h2>
      <table class="WTs_table">
        <thead>
          <tr>
            <th>Number</th>
            <th>Start Time</th>
            <th>End Time</th>
            <th>Total</th>
          </tr>
        </thead>
        <tbody>
          <tr class="WTs_items" v-for="item in totalWt" :key="item.id">
            <td class="WTs_item">
              <input
                class="select-wt"
                type="button"
                :value="item.id"
                @click="goWorkingTime"
              />
            </td>
            <td class="WTs_item">{{ format_date(item.start) }}</td>
            <td class="WTs_item">{{ format_date(item.end) }}</td>
            <td class="WTs_item">{{ item.total }}</td>
          </tr>
        </tbody>
      </table>
    </section>

    <!-- Create form -->

    <form
      id="create-form"
      v-if="isAddButtonSelected"
      @submit="createWorkingTime"
    >
      <fieldset>
        <h2 class="fs-title">Add working times</h2>
        <label for="start_date_input">Start Time</label>
        <input
          type="datetime-local"
          v-model="StartDate"
          id="start_date_input"
          name="start_date_input"
        />
        <br />
        <label for="end_date_input">End Time</label>
        <input
          type="datetime-local"
          v-model="EndDate"
          id="end_date_input"
          name="end_date_input"
        />
        <br />
        <input type="submit" id="create-submit" value="create" />
      </fieldset>
    </form>
  </main>
</template>

<script>
import axios from "axios";
import moment from "moment";
import { calculateTotalWorkingTime } from "../utils/utils";

export default {
  name: "WorkingsComponent",
  data() {
    return {
      currentUser: localStorage.getItem("currentUser")
        ? JSON.parse(localStorage.getItem("currentUser"))
        : {
            email: "",
            username: "",
            id: 0,
          },
      userId: 0,
      workingTimes: {},
      currentUserId: "",
      currentWorkingTimeId: "",
      form: {
        StartDate: new Date().toLocaleString(),
        EndDate: new Date().toLocaleString(),
      },
      isAddButtonSelected: false,
      totalWt: [],
    };
  },
  methods: {
    // get working times from user id
    getWorkingTimes(submitNumber) {
      submitNumber.preventDefault();
      if (!this.currentUser.id) {
        window.alert("Please select an employee");
        return;
      }
      axios.get(`/api/working_times/${this.userId}`).then((response) => {
        if (response.data.data.length > 0) {
          this.workingTimes = response.data.data;
          this.totalWt = this.workingTimes.map((wt) => {
            return { ...wt, total: calculateTotalWorkingTime(wt) };
          });
          this.currentUserId = this.$refs.userIdInput.value;
        } else {
          window.alert("No employee or working times found");
        }
      });
    },
    // Select one working time
    goWorkingTime(e) {
      axios.get(`/api/working_times/${this.userId}`).then((response) => {
        if (response.data.data.length > 0) {
          this.workingTimes = response.data.data;
          this.currentWorkingTimeId = e.target.value;
          console.log(`current workingtime id : ${this.currentWorkingTimeId}`);
          this.$router.push(
            `/workings/${this.currentUserId}/${this.currentWorkingTimeId}`
          );
        }
      });
    },
    // handle add working time button condition
    handleAddWorkingTime() {
      console.log("add WorkingTime button clicked");
      this.isAddButtonSelected = true;
    },
    // create working time
    createWorkingTime(e) {
      e.preventDefault();
      console.log("create submit button clicked");
      if (!this.currentUser.id) {
        window.alert("Please select an employee");
        return;
      }
      const body = {
        working_time: {
          start: moment.utc(moment(this.StartDate)).format("YYYY-MM-DD HH:mm"),
          end: moment.utc(moment(this.EndDate)).format("YYYY-MM-DD HH:mm"),
          // user: this.currentUserId,
        },
      };
      axios
        .post(`/api/working_times/${this.currentUser.id}`, body, {
          headers: {
            "Content-Type": "application/json",
          },
        })
        .then((response) => {
          console.log(response);
          window.alert("working time created");
          this.$router.go();
        });
      console.log(body);
    },
    format_hours(value) {
      return moment(String(value)).format("hh:mm");
    },
    format_day(value) {
      return moment(String(value)).format("dddd");
    },
    // Using moment library to format date
    format_date(value) {
      if (value) {
        return moment.utc(value).local().format("DD/MM/YYYY HH:mm");
      }
    },
  },
};
</script>

<style>
main {
  display: flex;
  flex-direction: column;
  width: 100%;
}

h1 {
  text-align: center;
  font-size: 24px;
  font-weight: bold;
}
/* search section */
.search-id {
  margin-left: 50px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 80%;
  height: 10%;
}

.search-id form {
  display: flex;
  align-items: center;
  height: 100%;
  widows: 30%;
}

.search-id form input {
  height: 30px;
  width: 45%;
  text-align: center;
  text-decoration: none;
}

.search-id form input:focus-visible {
  outline: none;
}

.search-id input[type="submit"]:hover,
#add-button:hover {
  border-color: #4caf50;
  color: #4caf50;
  background-color: white;
}
#add-button {
  height: 30px;
  width: 190px;
  text-align: center;
  text-decoration: none;
}

/*display table*/
.display-data {
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 90%;
  height: 75%;
}

.display-data h2 {
  font-size: 20px;
  font-weight: bold;
}

.WTs_table {
  border-collapse: collapse;
  width: 50%;
  border: 1px solid black;
  border-bottom: 1.1px solid black;
  font-weight: 700;
  text-align: center;
}
.WTs_table th {
  padding: 4px;
  text-align: center;
  color: white;
  background-color: #4caf50;
}

.WTs_table .WTs_items .WTs_item {
  border-bottom: 1px solid rgb(236, 231, 231);
  margin: 0 50px;
}

.select-wt {
  border: none;
  background-color: transparent;
}
.select-wt:hover {
  color: #4caf50;
  border-color: #4caf50;
  text-decoration: none;
}

/* add form */

#create-form {
  width: 400px;
  margin: 50px auto;
  text-align: center;
  position: relative;
}
#create-form h2 {
  font-size: 20px;
  font-weight: bold;
}

#create-form fieldset {
  background: white;
  border: 0 none;
  border-radius: 3px;
  box-shadow: 0 0 15px 1px rgba(0, 0, 0, 0.4);
  padding: 20px 30px;
  box-sizing: border-box;
  width: 80%;
  margin: 0 10%;
}

#create-form input {
  padding: 15px;
  border: 1px solid #ccc;
  border-radius: 3px;
  margin-bottom: 10px;
  width: 100%;
  box-sizing: border-box;
  font-family: montserrat;
  color: #2c3e50;
  font-size: 13px;
}
#create-form #create-submit {
  width: 100px;
  background: #27ae60;
  font-weight: bold;
  color: white;
  border: 0 none;
  border-radius: 1px;
  cursor: pointer;
  padding: 10px 5px;
  margin: 10px 5px;
}
#create-form #create-submit:hover,
#create-form #create-submit:focus {
  box-shadow: 0 0 0 2px white, 0 0 0 3px #27ae60;
}
</style>
