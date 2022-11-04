<template>

<section class="search-id">
      <form @submit.prevent="getWorkingTime">
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
    </section>
    <div>
        <apexchart width="500" type="bar" :options="options" :series="series"></apexchart>
    </div>
</template>

<script>
import axios from "axios";
import moment from "moment";
import { calculateTotalWorkingTime } from "src/utils/utils";

export default {
    name: 'GraphTest',
    data: function () {
        return {
            userId: 0,
            currentUserId: "",
            wtGraph: {
                day: 1,
                total: 0,
            },
            options: {
                chart: {
                    id: 'vuechart-example'
                },
                xaxis: {
                    categories: []
                }
            },
            series: [{
                name: 'series-1',
                data: []
            }],
            noData: {
                text: 'Loading...'
            },
        }
    },
    
    methods: {
        async getWorkingTime() {
            if (this.userId === "") {
                window.alert("Please enter an employee id");
                return;
            }
            const response = await axios.get(`/api/working_times/${this.userId}`)

    
                if (response.data.data.length > 0) {
                this.workingtime = response.data.data;
                // console.log(this.workingtime, "workingtimes");
                this.wtGraph = this.workingtime.map((wt) => {
                    console.log(wt, "wt");

                    return { ...wt, day: moment(wt.start).format("DD/MM/YYYY"), total: calculateTotalWorkingTime(wt) };
                })
                console.log(this.wtGraph, "wtGraph");
                this.currentUserId = this.$refs.userIdInput.value;
                } 
        ;

            let formattedWtGraph = this.wtGraph.map(({day, total}) => {
                return {
                    x: day,
                    y: total,
                }
            })
            console.log(formattedWtGraph, "formattedWtGraph");
            this.series = [
                {
                    name: "series-1",
                    data: formattedWtGraph,
                },
            
            ]
            console.log(this.series, "series");
        },   
    },
}

</script>