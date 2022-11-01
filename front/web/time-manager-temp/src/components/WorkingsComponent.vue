<template>
    <main>
        <h1>Check employee's working times</h1>
        <section class="search-id">
            <form @submit="getWorkingTimes">
                <label for="get_user_working_times" placeholder="enter employee id"></label>
                <input type="text" id="get_user_working_times" v-model="userId" placeholder="enter employee id"
                    ref="userIdInput" />
                <input type="submit" value="Get working times" />
            </form>
        </section>

        <section class="display-data">
            <h2>Employee n° {{ currentUserId }} Working Times:</h2>
            <table>
                <thead>
                    <tr>
                        <th>Number</th>
                        <th>Start Time</th>
                        <th>End Time</th>
                    </tr>
                </thead>
                <tbody>
                    <tr class="WT_items" v-for="item in workingTimes" :key="item.id">
                        <td><input class="select-wt" type="button" :value="item.id" @click="goWorkingTime"></td>
                        <td> {{ item.start }} </td>
                        <td>{{ item.end }}</td>
                    </tr>
                </tbody>
            </table>
        </section>
        <input type="button" value="Add more working times" @click="handleAddWorkingTime">

        <form v-if="isAddButtonSelected" @submit="createWorkingTime">
            <label for="start_date_input">Start Time</label>
            <input type="datetime-local" v-model="StartDate" id="start_date_input" name="start_date_input">
            <br>
            <label for="end_date_input">End Time</label>
            <input type="datetime-local" v-model="EndDate" id="end_date_input" name="end_date_input">
            <br>
            <input type="submit" id="create_working_time_submit" value="create">
        </form>


    </main>



</template>

<script>

import axios from "axios";

export default {
    name: "WorkingsComponent",
    data() {
        return {
            workingTimes: {},
            currentUserId: "",
            currentWorkingTimeId: "",
            form: {
                StartDate: new Date().toLocaleString(),
                EndDate: new Date().toLocaleString(),
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
                .get(`http://192.168.73.197:4000/api/working_times/${this.userId}`)
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
                .get(`http://192.168.73.197:4000/api/working_times/${this.userId}`)
                .then((response) => {
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
        handleAddWorkingTime() {
            console.log("add WorkingTime button clicked");
            this.isAddButtonSelected = true;
        },
        createWorkingTime(e) {
            e.preventDefault();
            console.log("create submit button clicked");
            if (this.userId === "") {
                window.alert("no employee id found");
                return;
            }
            const body = {
                working_time: {
                    start: this.StartDate,
                    end: this.EndDate,
                    // user: this.currentUserId,
                },
            };
            axios
                .post(`http://192.168.73.197:4000/api/working_times/${this.userId}`, body, {
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

<style>
    main {
        display: flex;
        flex-direction: column;
        width: 100%;
        height: 100vh;
    }

    h1 {
        text-align: center;
        font-size: 24px;
        font-weight: bold;
    }

    .search-id {
        margin-left: 50px;
        display: flex;
        align-items: center;
        width: 100%;
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

    .search-id input[type="submit"]:hover {
        border-color: #4CAF50;
        color: #4CAF50;
        background-color: white;
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
        border-collapse: collapse;
        width: 50%;
        border: 1px solid black;
        border-bottom: 1.1px solid black;
        font-weight: 700;
        text-align: center;
    }
    table th {
        padding: 4px;
        text-align: center;
        color: white;
        background-color: #4CAF50;
    }

    tbody tr {
        border-bottom: 1px solid rgb(236, 231, 231);
        margin: 0 50px;
    }

    .select-wt {
        border: none;
        background-color: transparent;
    }
    .select-wt:hover {
        color: #4CAF50;
        border-color: #4CAF50;
        text-decoration: none;
    }



</style>