<!-- <template>

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
</template> -->

<!-- <script>
import axios from "axios";
import moment from "moment";
import { calculateTotalWorkingTime } from "src/utils/utils";

export default {
    name: 'GraphTest',
    // data () {
    //     return {
    //         wtGraph: {
    //             day: "",
    //             total: 0,
    //         },
    //         options: {
    //             chart: {
    //                 id: 'barchart-example'
    //             },
    //             title: {
    //                 text: 'Working times by date',
    //                 align: 'left'
    //             },
    //             fill: {
    //                 colors: ['#4CAF50']
    //             },
    //             yaxis: {
    //                 min: 0,
    //                 max: 10,
    //                 title: {
    //                     text: 'Working time (hours)'
    //                 },
    //                 // labels: {
    //                 //     formatter: function (val) {
    //                 //         return val + "h";
    //                 //     }
    //                 // }
    //             },

    //             xaxis: {
    //                 categories: [],
    //                 title: {
    //                     text: 'working time (date)'
    //                 }  
    //             }
    //         },
    //         series: [{
    //             name: '1',
    //             data: []
    //         }],
    //         noData: {
    //             text: 'Loading...'
    //         },
    //     }
    // },
    
    // methods: {

    //     async getWorkingTime() {
    //         if (this.userId === "") {
    //             window.alert("Please enter an employee id");
    //             return;
    //         }
    //         const response = await axios.get(`/api/working_times/${this.userId}`)

    
    //             if (response.data.data.length > 0) {
    //             this.workingtime = response.data.data;
    //             // console.log(this.workingtime, "workingtimes");
    //             this.wtGraph = this.workingtime.map((wt) => {
    //                 console.log(wt, "wt");

    //                 return { ...wt, day: moment(wt.start).format("DD/MM/YYYY"), total: calculateTotalWorkingTime(wt) };
    //             })
    //             console.log(this.wtGraph, "wtGraph");
    //             } 
    //     ;

    //         let formattedWtGraph = this.wtGraph.map(({day, total}) => {
    //             return {
    //                 x: day,
    //                 y: total,
    //             }
    //         })
    //         console.log(formattedWtGraph, "formattedWtGraph");
    //         this.series = [
    //             {
    //                 name: "series-1",
    //                 data: formattedWtGraph,
    //             },
            
    //         ]
    //         console.log(this.series, "series");
    //     },   
    // },
}

</script> -->

<style>
.bar-chart {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-top: 50px;
}

#barchart-example {
    max-width: 800px;
    margin: 35px auto;
}

#scatter {
    max-width: 800px;
    margin: 35px auto;
}

</style>

<template>
    
    <div class="bar-chart">
        <apexchart width=700 height=350 type="bar" :options="barChartOptions" :series="barSeries"></apexchart>
    </div>
    <div id="scatter">
        <apexchart type="scatter" :options="scatterChartOptions" :series="scatterSeries"></apexchart>
    </div>
</template>

<script>
import axios from "axios";
import moment from "moment";
import { calculateTotalWorkingTime } from "src/utils/utils";

export default {
    name: 'GraphTest',
    data() {
        return {
            currentUser: localStorage.getItem("currentUser")
                ? JSON.parse(localStorage.getItem("currentUser"))
                : {
                    email: "",
                    username: "",
                    id: 0,
                },
            workingtimeGraph: {},
            // bar chart test
            barSeries: [
                {
                    name: 'Current Hours',
                    data: []
                }
            ],
            barChartOptions: {
                chart: {
                    id: 'barchart-example'
                },

                plotOptions: {
                    bar: {
                        horizontal: true,
                    }
                },
                colors: ['#00E396'],
                dataLabels: {
                    formatter: function (val, opt) {
                        const goals =
                            opt.w.config.series[opt.seriesIndex].data[opt.dataPointIndex]
                                .goals

                        if (goals && goals.length) {
                            return `${val} / ${goals[0].value}`
                        }
                        return val
                    }
                },
                legend: {
                    show: true,
                    showForSingleSeries: true,
                    customLegendItems: ['Current Hours', 'Expected'],
                    markers: {
                        fillColors: ['#00E396', '#775DD0']
                    }
                }
            },
            // scatter chart test
            userClocksGraph: {
            },
            
            scatterSeries: [
                {
                    name: "SAMPLE A",
                    data: [],
                }, 

                {
                    name: "SAMPLE B",
                    data: [],
                }, 
                
            ],
            scatterChartOptions: {
                chart: {
                    height: 350,
                    width: 500,
                    type: 'scatter',
                },
            },
            
            
            
        }
    },

    methods: {
        async getWorkingTimesWithGoals() {
            const response = await axios.get(`/api/working_times/${this.currentUser.id}`)
            if (response.data.data.length > 0) {
                const workingtimes = response.data.data;
                this.workingtimeGraph = workingtimes.map((wt) => {
                    console.log(wt, "wt");
                    return {
                        ...wt,
                        day: moment(wt.start).format("dddd"),
                        total: calculateTotalWorkingTime(wt),
                    }
                    console.log(this.workingtimeGraph, "workingtimeGraph");
                })
            }
            let formattedWorkingTimeGraph = this.workingtimeGraph.map(({ day, total }) => {
                return {
                    x: day,
                    y: total,
                    goals: [
                        {
                            name: 'Expected',
                            value: 8,
                        }
                    ],
                }
            })
            this.barSeries = [
                {
                    name: "Current Hours",
                    data: formattedWorkingTimeGraph,
                },
            ]

        },
        async getClocksSeries() {
            const response = await axios.get(`/api/clocks/${this.currentUser.id}`)
            if (response.data.data.length > 0) {
                let clocks = response.data.data;
                console.log(clocks, "clocks");
                this.userClocksGraph = clocks.map((clock) => {
                    let clockDayTime = moment.utc(clock.time).local().format("DD/MM/YYYY HH:mm")
                    return {
                        ...clock,
                        day: clockDayTime,
                        start: clock.time,
                    }
                })
            }
            console.log(this.userClocksGraph, "userClocksGraph");
            let formattedUserClocksGraph = this.userClocksGraph.map(({day, start}) => {
                return {
                    x: day,
                    y: moment(start).format("HH:mm"),
                }
            })
            console.log(formattedUserClocksGraph, "formattedUserClocksGraph");
            this.scatterSeries = [
                {
                    name: "SAMPLE A",
                    data: formattedUserClocksGraph,
                },
            ]
            console.log(this.scatterSeries, "scatter series");
        }
        
    },
    mounted() {
        this.getWorkingTimesWithGoals();
        this.getClocksSeries();
    }
}
</script>