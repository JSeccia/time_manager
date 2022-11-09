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
    <!-- <div id="scatter">
        <apexchart type="scatter" :options="scatterChartOptions" :series="scatterSeries"></apexchart>
    </div>
    -->
</template>

<script>
import axios from "axios";
import moment from "moment";
import { calculateTotalWorkingTime, calculateTotalWorkingTimeinMinutes } from "src/utils/utils";
import { useUserStore } from "src/stores/store-users";

export default {
    name: 'GraphTest',
    setup() {
        const store = useUserStore();
        return {
            store,
        }
    },
    data() {
        return {
            currentUser: this.store.user,
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
            // userClocksGraph: {
            // },
            
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
            // getall wts
            wts: {},
            // get week wts start end
            weekWts: {},


            
            
            
        }
    },

    methods: {
        async getWorkingTimesWithGoals() {
            const response = await axios.get(`/api/working_times/${this.currentUser.id}`)
            if (response.data.data.length > 0) {
                const workingtimes = response.data.data;
                this.workingtimeGraph = workingtimes.map((wt) => {
                    // console.log(wt, "wt");
                    return {
                        ...wt,
                        day: moment(wt.start).format("dddd"),
                        total: calculateTotalWorkingTime(wt),
                    }
                    // console.log(this.workingtimeGraph, "workingtimeGraph");
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
        // async getClocksSeries() {
        //     const response = await axios.get(`/api/clocks/${this.currentUser.id}`)
        //     if (response.data.data.length > 0) {
        //         let clocks = response.data.data;
        //         // console.log(clocks, "clocks");
        //         this.userClocksGraph = clocks.map((clock) => {
        //             let clockDayTime = moment.utc(clock.time).local().format("DD/MM/YYYY HH:mm")
        //             return {
        //                 ...clock,
        //                 day: clockDayTime,
        //                 start: clock.time,
        //             }
        //         })
        //     }
        //     // console.log(this.userClocksGraph, "userClocksGraph");
        //     let formattedUserClocksGraph = this.userClocksGraph.map(({day, start}) => {
        //         return {
        //             x: day,
        //             y: moment(start).format("HH:mm"),
        //         }
        //     })
        //     // console.log(formattedUserClocksGraph, "formattedUserClocksGraph");
        //     this.scatterSeries = [
        //         {
        //             name: "SAMPLE A",
        //             data: formattedUserClocksGraph,
        //         },
        //     ]
        //     console.log(this.scatterSeries, "scatter series");
        // }
        
    async getAverageWTsForAllUsers() {
        const response = await axios.get(`/api/working_times`)
    if(response.status === 200) {
    const wts = response.data.data
    this.wts = wts.map((wt) => {
        return {
            ...wt, 
            totalminutes: calculateTotalWorkingTimeinMinutes(wt),
        }
    })
    // console.log(this.wts, "wts with total");
    const totalminutes = this.wts.map((wt) => {
        return wt['totalminutes'];
    })
    const totalminutesvalues = Object.values(totalminutes)
    const sum = totalminutesvalues.reduce((a, b) => a + b, 0) / totalminutesvalues.length;
    // console.log(sum, "sum");
    const hours = Math.floor(sum / 60);
    const minutes = (sum % 60).toFixed(0);
    const averageWorkedtime = `${hours}h: ${minutes}m`;
    // console.log(averageWorkedtime, "averageworkedtime");
    return averageWorkedtime;


    };
    },
    async getAverageWTsForUser() {
        const response = await axios.get(`/api/working_times/${this.currentUser.id}`)
    if(response.status === 200) {
    const wts = response.data.data
    this.wts = wts.map((wt) => {
        return {
            ...wt, 
            totalminutes: calculateTotalWorkingTimeinMinutes(wt),
        }
    })
    // console.log(this.wts, "wts with total");
    const totalminutes = this.wts.map((wt) => {
        return wt['totalminutes'];
    })
    const totalminutesvalues = Object.values(totalminutes)
    const sum = totalminutesvalues.reduce((a, b) => a + b, 0) / totalminutesvalues.length;
    // console.log(sum, "sum");
    const hours = Math.floor(sum / 60);
    const minutes = (sum % 60).toFixed(0);
    const averageWorkedtime = `${hours}h: ${minutes}m`;
    // console.log(averageWorkedtime, "averageworkedtime");
    return averageWorkedtime;


    };
    },

    async getWeekWTSByUser() {
        const response = await axios.get(`/api/working_times/${this.currentUser.id}`)
        // console.log(response, "response");
        if (response.status === 200) {
            // const start = moment().startOf('week').format("YYYY-MM-DD");
            const obj = response.data.data;
             this.weekWts = obj.filter((wt) => {
                return moment(wt.start).isBetween(moment().startOf('week'), moment().endOf('week'))
            })
            const w = this.weekWts.map((wt) => {
                return wt['start']
            })
            const week = Object.values(w)
            // console.log(currentWeek, "currentWeek");
            const cwSort = week.sort()
            console.log(cwSort, "cwSort");
            const currentWeek = cwSort.map((wt) => {
                return moment(wt).format("dddd")
            })
            console.log(currentWeek, "currentWeek");

        }

    },
        
        
// recupere les working times 
// on map dessur pour
// recupere le start et le end de tous les wt des users 
// on les convertis en moment et en minutes
// on les additionne
// on divise par le nombre de wt
// on retourne le resultat

    },
    mounted() {
        this.getWorkingTimesWithGoals();
        // this.getClocksSeries();
        this.getAverageWTsForAllUsers();
        this.getAverageWTsForUser();
        this.getWeekWTSByUser();
    }
}
</script>