<template>

  <!-- Manager Web Working Times -->
  <main class="main-workingtimes">
    <h1>Check working times</h1>

    <ul :key="currentUser.id">
      <li>{{ currentUser.id }}</li>
      <li>{{ currentUser.username }}</li>
      <li>{{ currentUser.email }}</li>
    </ul>
    <!-- Search Employee Id form -->

    <section class="search-wt-id">
      <form @submit.prevent="getWorkingTimes">
        <label
          for="get_user_working_times"
        ></label>
        <q-input rounded outlined v-model="userId" class="search_wt_input" placeholder="enter employee id" ref="userIdInput" id="get_user_working_times"
            color="green-10">
        </q-input>
        <q-btn id="add-button" type="submit" class="search_wt_btn" push color="green-10" label="Get working times" />

      </form>
      
      <!-- add working times button -->
      <q-btn
        href="#create-form"
        id="add-button"
        type="button"
        label="Add working times"
        push color="green-10"
        @click="handleAddWorkingTime"
      />
    </section>

    <!-- Display Employee's Working Times from its ID -->

    <section class="display-wt-data" v-if="isSubmitButtonSelected">
      <h2>Employee n° {{ userId }} Working Times:</h2>
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
          <tr class="WTs_items" v-for="item in wtGraph" :key="item.id">
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
      <div class="bar-chart">
          <apexchart width="600" type="bar" :options="options" :series="series"></apexchart>
      </div>
    </section>
    <!-- Create form -->

    <form
      id="create-form"
      v-if="isAddButtonSelected"
      @submit.prevent="createWorkingTime"
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
        <q-btn id="create-submit" type="submit" class="create_wt_btn" push color="green-10" label="create" />
      </fieldset>
    </form>


  </main>

  <!-- Employee web WorkingTimes -->
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
      workingTimes: {},
      currentUserId: "",
      currentWorkingTimeId: "",
      form: {
        StartDate: new Date().toLocaleString(),
        EndDate: new Date().toLocaleString(),
      },
      isAddButtonSelected: false,
      isSubmitButtonSelected: false,


      // Inplemented wtGraph to display working times in a chart


      wtGraph: {
          day: "",
          total: 0,
      },
      options: {
          chart: {
              id: 'barchart-example'
          },
          plotOptions: {
              bar: {
                  columnWidth: '50%',
                  endingShape: 'rounded'
              },
          },
          title: {
              text: 'Working times by date',
              align: 'left'
          },
          fill: {
              colors: ['#4CAF50']
          },
          yaxis: {
              min: 0,
              max: 24,
              title: {
                  text: 'Working time (hours)'
              },
          },
          xaxis: {
              categories: [],
              title: {
                  text: 'working time (date)'
              }  
          }
      },
      series: [{
          name: '1',
          data: []
      }],
      noData: {
          text: 'Loading...'
      },
  
    };
  },
  methods: {
    // get working times from user id
    async getWorkingTimes() {
      if (!this.currentUser.id) {
        window.alert("Please select an employee");
        return;
      }
      const response = await axios.get(`/api/working_times/${this.userId}`)
      if (response.data.data.length > 0) {
        this.workingTimes = response.data.data;
        this.currentUserId = this.$refs.userIdInput.value;
        this.wtGraph = this.workingTimes.map((wt) => {
          return { ...wt, day: moment(wt.start).format("DD/MM/YYYY"), total: calculateTotalWorkingTime(wt) };
        })
      } 

      let formattedWtGraph = this.wtGraph.map(({day, total}) => {
        return {
          x: day,
          y: total,
        }
      })
      this.series =  [
        {
          name: "series-2",
          data: formattedWtGraph,
        },
      ]
      console.log(this.series, "series");
      this.isSubmitButtonSelected = true;
    },
  
    // Select one working time
    goWorkingTime(e) {
      axios.get(`/api/working_times/${this.userId}`).then((response) => {
        if (response.data.data.length > 0) {
          this.workingTimes = response.data.data;
          this.currentWorkingTimeId = e.target.value;
          console.log(`current workingtime id : ${this.currentWorkingTimeId}`);
          this.$router.push(
            `/workings/${this.userId}/${this.currentWorkingTimeId}`
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
    // Using moment library to format date
    format_date(value) {
      if (value) {
        return moment.utc(value).local().format("DD/MM/YYYY HH:mm");
      }
    },
  },
  mounted() {
    this.getWorkingTimes();
  },
};
</script>

<style>
.main-workingtimes {
  display: flex;
  flex-direction: column;
  width: 100vw;
}

.main-workingtimes h1 {
  font-size: 25px;
  font-weight: bold;
  border-bottom: 2px solid black;
  height: 10%;
}
/* search section */
.search-wt-id {
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 85%;
  height: 10%;
}

.search-wt-id form {
  display: flex;
  justify-content: center;
  align-items: center;
}

.search-wt-id form .search_wt_input {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 45%;
  height: 30px;
  margin: 2%;
}

.search-wt-id form .search_wt_input .self-stretch {
  align-self: center;
}

.search-wt-id form .search_wt_input .q-field__control {
 height: 40px;
}

.search-wt-id form .search_wt_input .q-field__control .q-field__native {
  font-size: 15px;
}

.search-wt-id input[type="submit"]:hover,
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
.display-wt-data {
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 90%;
  height: 75%;
}

.display-wt-data h2 {
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
  background-color: rgba(76, 175, 80, 0.14);
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
  box-shadow: 0 0 0 2px white;
}
</style>
