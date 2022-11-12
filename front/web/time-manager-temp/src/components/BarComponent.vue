<template>
    
    
        <h2>Total Working Times By week</h2>
        <apexchart width=500 height=350 type="bar" :options="bar1ChartOptions" :series="bar1Series"></apexchart>

</template>

<script>
import axios from "axios";
import moment from "moment";
import { calculateTotalWorkingTime, calculateTotalWorkingTimeinMinutes } from "src/utils/utils";
import { useUserStore } from "src/stores/store-users";

export default {
    name: 'BarComponent',
    setup() {
        const store = useUserStore();
        return {
            store
        }
    },
    data() {
        return {
            currentUser: this.store.user,
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
                colors: ['#556B2F', '#4CAF50'],

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
                


            },
            legend: {
                show: true,
                showForSingleSeries: true,
                customLegendItems: ['User current working times', 'Users Average working times'],

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
            wts: {},
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
    },
    mounted() {
        this.getWorkingTimesWithGoals();
        this.getAverageByWeekWTsForAllUsers();
    },
}
</script>