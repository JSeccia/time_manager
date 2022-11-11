


<template>
    <div class="bar-chart">
        <apexchart width=700 height=350 type="bar" :options="bar1ChartOptions" :series="bar1Series"></apexchart>
    </div>
    <!-- <div id="scatter">
        <apexchart type="scatter" :options="scatterChartOptions" :series="scatterSeries"></apexchart>
    </div>
    -->
    <div class="bar-chart">
        <apexchart width=700 height=350 type="bar" :options="bar2ChartOptions" :series="bar2Series"></apexchart>
    </div>
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
            bar1Series: [
                {
                    name: 'Current Hours',
                    data: []
                }
            ],
            bar1ChartOptions: {
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
            // bar chart with daily working times
            bar2Series: [
                {
                    name: 'Daily Worked Hours',
                    data: []
                }
            ],
            bar2ChartOptions: {
                chart: {
                    id: 'bar2chart'
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
            WtObject: {},   
        }
    },

    methods: {
        async getWorkingTimesWithGoals() {
            const response = await axios.get(`/api/working_times/${this.currentUser.id}`)
            if (response.data.data.length > 0) {
                const workingtimes = response.data.data;
                this.workingtimeGraph = workingtimes.map((wt) => {
                    return {
                        ...wt,
                        day: moment(wt.start).format("dddd"),
                        total: calculateTotalWorkingTime(wt),
                    }
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
            this.bar1Series = [
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
        //         this.userClocksGraph = clocks.map((clock) => {
        //             let clockDayTime = moment.utc(clock.time).local().format("DD/MM/YYYY HH:mm")
        //             return {
        //                 ...clock,
        //                 day: clockDayTime,
        //                 start: clock.time,
        //             }
        //         })
        //     }
        //     let formattedUserClocksGraph = this.userClocksGraph.map(({day, start}) => {
        //         return {
        //             x: day,
        //             y: moment(start).format("HH:mm"),
        //         }
        //     })
        //     this.scatterSeries = [
        //         {
        //             name: "SAMPLE A",
        //             data: formattedUserClocksGraph,
        //         },
        //     ]
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
        const totalminutes = this.wts.map((wt) => {
            return wt['totalminutes'];
        })
        const totalminutesvalues = Object.values(totalminutes)
        const sum = totalminutesvalues.reduce((a, b) => a + b, 0) / totalminutesvalues.length;
        const hours = Math.floor(sum / 60);
        const minutes = (sum % 60).toFixed(0);
        const averageWorkedtime = `${hours}h: ${minutes}m`;
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

        const totalminutes = this.wts.map((wt) => {
            return wt['totalminutes'];
        })
        const totalminutesvalues = Object.values(totalminutes)
        const sum = totalminutesvalues.reduce((a, b) => a + b, 0) / totalminutesvalues.length;
        const hours = Math.floor(sum / 60);
        const minutes = (sum % 60).toFixed(0);
        const averageWorkedtime = `${hours}h: ${minutes}m`;
        return averageWorkedtime;


        };
        },

        async getWeekWTSByUser() {
            const response = await axios.get(`/api/working_times/${this.currentUser.id}`)

            if (response.status === 200) {
                const obj = response.data.data;
                this.weekWts = obj.filter((wt) => {
                    return moment(wt.start).isBetween(moment().startOf('week'), moment().endOf('week'))
                })
                const w = this.weekWts.map((wt) => {
                    return wt['start']
                })
                const week = Object.values(w)
                const cwSort = week.sort()
                const currentWeek = cwSort.map((wt) => {
                    return moment(wt).format("dddd")
                })

                
            }

        },
        async getUserWTByWeekDay() {
            const response = await axios.get(`/api/working_times/${this.currentUser.id}`)
            this.WtObject = response.data.data;
            let SortedWorkingTimes = this.WtObject.sort((a, b) => {
                return new Date(a.start) - new Date(b.start);
            });
            const FilteredWorkingTimes  = SortedWorkingTimes.filter((wt) => {
                    return moment(wt.start).isBetween(moment().startOf('week'), moment().endOf('week'))
                })
            console.log(FilteredWorkingTimes, "FilteredWorkingTimes");
            const AddKeyToWorkingTimes = FilteredWorkingTimes.map((wt) => {
                return {
                ...wt,
                weekDay: moment(wt.start).format("dddd"),
                totalHours: calculateTotalWorkingTime(wt),
                };
            });
              let bar2graph = AddKeyToWorkingTimes.map(({ weekDay, totalHours }) => {
                return {
                    x: weekDay,
                    y: totalHours,
                    goals: [
                    {
                        name: "Expected",
                        value: 7,
                    },
                    ],
                };
                });
                this.bar2Series = [
                {
                    name: "Daily Worked Hours",
                    data: bar2graph,
                },
                ];
        },
    },
    mounted() {
        this.getWorkingTimesWithGoals();
        this.getAverageWTsForAllUsers();
        this.getAverageWTsForUser();
        this.getWeekWTSByUser();
        this.getUserWTByWeekDay();
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
    max-width: 800px;
    margin: 35px auto;
}

#scatter {
    max-width: 800px;
    margin: 35px auto;
}

</style>