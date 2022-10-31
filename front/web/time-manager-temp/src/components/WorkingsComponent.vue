<template>
    <h1>Check employee's working times</h1>
    <br>
    <form @submit="getWorkingTimes">
        <label for="get_user_working_times" placeholder="enter employee id"></label>
        <input type="text" id="get_user_working_times" v-model="userId" placeholder="enter employee id"
            ref="userIdInput" />
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
        <input type="datetime-local" v-model="StartDate" id="start_date_input" name="start_date_input">
        <br>
        <label for="end_date_input">End Time</label>
        <input type="datetime-local" v-model="EndDate" id="end_date_input" name="end_date_input">
        <br>
        <input type="submit" id="create_working_time_submit" value="create">
    </form>
</template>






<script>

export default {
    name: "WorkingTimes",
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