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
    <div class="bar-chart">
        <apexchart width="600" type="bar" :options="options" :series="series"></apexchart>
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
            wtGraph: {
                day: "",
                total: 0,
            },
            options: {
                chart: {
                    id: 'barchart-example'
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
                    max: 10,
                    title: {
                        text: 'Working time (hours)'
                    },
                    // labels: {
                    //     formatter: function (val) {
                    //         return val + "h";
                    //     }
                    // }
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

<style>

.bar-chart {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-top: 50px;
}
#barchart-example {
    max-width: 500px;
    margin: 35px auto;
}

</style>