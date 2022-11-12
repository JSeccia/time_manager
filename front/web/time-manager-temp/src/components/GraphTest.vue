<template>


    <div class="bar-chart">
        <apexchart width=700 height=350 type="bar" :options="bar1ChartOptions" :series="bar1Series"></apexchart>
    </div>


    <q-btn label="Week" @click="handleWeek" />
    <q-btn label="Month" @click="handleMonth" />
    <q-btn label="Year" @click="handleYear" />

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
                },
            ],
            bar1ChartOptions: {
                chart: {
                    id: 'barchart-example'
                },

                plotOptions: {
                    bar: {
                        horizontal: false,

                    }
                },
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
                fill: {
                },


            },
            legend: {
                show: true,
                showForSingleSeries: true,
                customLegendItems: ['Current Hours', 'Average Hours'],
            },
            tooltip: {
                shared: true,
                intersect: false,
                y: {
                    formatter: function (y) {
                        if (typeof y !== 'undefined') {
                            return y.toFixed(0) + ' hours'
                        }
                        return y
                    }
                }
            },
            // getall wts
            wts: {},
            // get week wts start end
            weekWts: {},


            // bar chart for one user sorted by day, month and year 
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
                colors: [
                    function ({ value }) {
                        if (value < 7) {
                            return '#FF4560'
                        } else {
                            return '#00E396'
                        }
                    }
                ],
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
            monthBtnSelected: false,
            weekBtnSelected: false,
            yearBtnSelected: false,
           
            wtsAllUsers: [],
        }
    },

    methods: {

        async getAverageByWeekWTsForAllUsers() {
            const response = await axios.get(`/api/working_times`)
            if (response.status === 200) {
                this.wts = response.data.data.map((wt) => {
                    return {
                        ...wt,
                        day: moment(wt.start).format("dddd"),
                        totalminutes: calculateTotalWorkingTimeinMinutes(wt),
                    }
                })
                console.log(this.wts, "wts")
                const averagebyDay = this.wts.reduce((acc, wt) => {
                    const { day, totalminutes } = wt;
                    if (!acc[day]) {
                        acc[day] = {
                            day,
                            totalminutes: 0,
                            count: 0,
                        };
                    }
                    acc[day].totalminutes += totalminutes;
                    acc[day].count++;
                    return acc;
                }, {});
                console.log(averagebyDay, "averagebyDay");
                const averagebyDayList = Object.values(averagebyDay).map((wt) => {
                    return {
                        ...wt,
                        average: Math.floor((wt.totalminutes / wt.count) / 60),

                    };
                });
                this.wtsAllUsers = averagebyDayList.map((wt) => {
                    return {
                        x: wt.day,
                        y: wt.average,
                        fillColor: '#4CAF50',               
                    }
                })
            };
        },
       
        async getWorkingTimesWithGoals() {
            await this.getAverageByWeekWTsForAllUsers();
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
                let formattedWorkingTimeGraph = this.workingtimeGraph.map(({ day, total }) => {
                    return {
                        x: day,
                        y: total,
                        fillColor: "#556B2F",

                        goals: [
                            {
                                name: 'Expected',
                                value: 8,

                            }
                        ],
                    }
                })
                console.log(formattedWorkingTimeGraph, "formattedWorkingTimeGraph");
                this.bar1Series = [
                    {
                        name: "Current Hours",
                        data: formattedWorkingTimeGraph,
                        type: "bar",
                       
                    },
                    {
                        name: "Average Hours",
                        data: this.wtsAllUsers,
                        type: "bar",

                    },
                ]
                console.log(this.bar1Series, "bar1series"); 
            }
        },

        async getAverageWTsForAllUsers() {
            const response = await axios.get(`/api/working_times`)
            if (response.status === 200) {
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
            if (response.status === 200) {
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

        // get User Working Times by week day, month, year
        async getUserWTsGraph() {
            const response = await axios.get(`/api/working_times/${this.currentUser.id}`)
            this.WtObject = response.data.data;
            let SortedWorkingTimes = this.WtObject.sort((a, b) => {
                return new Date(a.start) - new Date(b.start);
            });
            let AddKeyToWorkingTimes = {};
            if (this.monthBtnSelected === true) {
                // console.log("month graph")
                const FilteredWorkingTimes = SortedWorkingTimes.filter((wt) => {
                    return moment(wt.start).isBetween(moment().startOf('month'), moment().endOf('month'))
                })
                AddKeyToWorkingTimes = FilteredWorkingTimes.map((wt) => {
                    return {
                        ...wt,
                        weekDay: moment(wt.start).format("DD - MMM"),
                        totalHours: calculateTotalWorkingTime(wt),
                    };
                });
            } else if (this.yearBtnSelected === true) {
                // console.log("year graph")
                const FilteredWorkingTimes = SortedWorkingTimes.filter((wt) => {
                    return moment(wt.start).isBetween(moment().startOf('year'), moment().endOf('year'))
                })
                AddKeyToWorkingTimes = FilteredWorkingTimes.map((wt) => {
                    return {
                        ...wt,
                        weekDay: moment(wt.start).format("DD-MM-YYYY"),
                        totalHours: calculateTotalWorkingTime(wt),
                    };
                });
            } else {
                // console.log("week graph")
                const FilteredWorkingTimes = SortedWorkingTimes.filter((wt) => {
                    return moment(wt.start).isBetween(moment().startOf('week'), moment().endOf('week'))
                })
                AddKeyToWorkingTimes = FilteredWorkingTimes.map((wt) => {
                    return {
                        ...wt,
                        weekDay: moment(wt.start).format("dddd"),
                        totalHours: calculateTotalWorkingTime(wt),
                    };
                });
            }

            // const GroupByWeekDay = AddKeyToWorkingTimes.reduce((r, a) => {
            //     r[a.weekDay] = [...r[a.weekDay] || [], a];
            //     return r;
            // }, {});
            const totalmin = AddKeyToWorkingTimes.map((wt) => {
                return wt['totalHours'];
            })
            const splitTime = totalmin.map((b) => {
                return moment.duration(b, 'minutes').asMinutes();
            })
            const totalminutesvalues = splitTime.reduce((a, b) => a + b, 0);
            const hours = Math.floor(totalminutesvalues / 60);
            const minutes = totalminutesvalues % 60;
            const totaltime = `${hours}h: ${minutes}m`;
            let bar2graph = AddKeyToWorkingTimes.map(({ weekDay, totalHours }) => {
                return {
                    x: weekDay,
                    y: totalHours,
                    goals: [
                        {
                            name: "Expected",
                            value: 7,
                            strokeHeight: 4,

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

        //handle month btn clicked
        handleMonth() {
            this.monthBtnSelected = true;
            this.weekBtnSelected = false;
            this.yearBtnSelected = false;
            this.getUserWTsGraph();
        },
        //handle week btn clicked
        handleWeek() {
            this.weekBtnSelected = true;
            this.monthBtnSelected = false;
            this.yearBtnSelected = false;
            this.getUserWTsGraph();
        },
        //handle year btn clicked
        handleYear() {
            this.yearBtnSelected = true;
            this.monthBtnSelected = false;
            this.weekBtnSelected = false;
            this.getUserWTsGraph();
        },
    },
    mounted() {
        this.getAverageByWeekWTsForAllUsers();
        this.getWorkingTimesWithGoals();
        // this.getAverageWTsForAllUsers();
        // this.getAverageWTsForUser();
        this.getWeekWTSByUser();
        this.getUserWTsGraph();
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
</style>