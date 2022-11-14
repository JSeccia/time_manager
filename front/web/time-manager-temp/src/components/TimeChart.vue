<template>
    <div class="timechart-btn">
        <q-btn label="Week" @click="handleWeek" push color="green-8" />
        <q-btn label="Month" @click="handleMonth" push color="green-7"/>
        <q-btn label="Year" @click="handleYear" push color="green-6"/>
    </div>

    <div class="bar-chart">
        <apexchart width=700 height=350 type="bar" :options="bar2ChartOptions" :series="bar2Series"></apexchart>
    </div>
</template>

<script>
import axios from "axios";
import moment from "moment";
import { calculateTotalWorkingTime, calculateTotalWorkingTimeinMinutes } from "src/utils/utils";
import { useUserStore } from "src/stores/store-users";
import BarComponent from "src/components/BarComponent.vue";

export default {
    name: 'TimeChart',
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
                            return '#556B2F'
                        } else {
                            return '#4CAF50'
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
                    customLegendItems: ['Hours', 'Exceeded Hours'],
                    markers: {
                        fillColors: ['#556B2F', '#4CAF50']
                    }
                }
            },

            WtObject: {},
            monthBtnSelected: false,
            weekBtnSelected: false,
            yearBtnSelected: false,
           
            // wtsAllUsers: [],
        }
    },

    methods: {
        // get User Working Times by week day, month, year
        async getUserWTsGraph() {
            const response = await axios.get(`/api/working_times/${this.currentUser.id}`)
            this.WtObject = response.data.data.slice(Math.max(response.data.data.length - 10, 0));
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

.timechart-btn  {
    display: flex;
    width: 45%;    
}

.timechart-btn button {
    margin-right: 10px;
}
</style>