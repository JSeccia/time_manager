<template>
  <div class="WT_charts">
    <div class="title_WT">
      <h2>Team Activity</h2>
      <apexchart
        type="pie"
        :options="pieOptionsChart"
        :series="pieSeries"
      ></apexchart>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import { calculateTotalWorkingTimeinMinutes } from "src/utils/utils";

import { useUserStore } from "src/stores/store-users";

export default {
  name: "PieComponent",
  setup() {
    const store = useUserStore();
    return {
      store,
    };
  },
  data() {
    return {
      pieSeries: [],

      pieOptionsChart: {
        chart: {
          width: 200,
          type: "pie",
        },

        labels: [],
        plotOptions: {
          pie: {
            dataLabels: {
              offset: -5,
            },
          },
        },

        dataLabels: {
          formatter(val, opts) {
            const name = opts.w.globals.labels[opts.seriesIndex];
            return [name, val.toFixed(1) + "%"];
          },
        },

        legend: {
          show: true,
        },
        responsive: [
          {
            breakpoint: 480,
            options: {
              chart: {
                width: 200,
              },
              legend: {
                position: "bottom",
              },
            },
          },
          {
            breakpoint: 768,
            options: {
              chart: {
                width: 300,
              },
              legend: {
                position: "bottom",
              },
            },
          },
          {
            breakpoint: 1024,
            options: {
              chart: {
                width: 400,
              },
              legend: {
                position: "bottom",
              },
            },
          },
          {
            breakpoint: 1280,
            options: {
              chart: {
                width: 400,
              },
              legend: {
                position: "right",
              },
            },
          },
          {
            breakpoint: 1366,
            options: {
              chart: {
                width: 400,
              },
              legend: {
                position: "right",
              },
            },
          },
          {
            breakpoint: 1840,
            options: {
              chart: {
                width: 500,
              },
              legend: {
                position: "right",
              },
            },
          },
          {
            breakpoint: 2020,
            options: {
              chart: {
                width: 500,
              },
              legend: {
                position: "right",
              },
            },
          },
        ],
      },
      userTeamId: {},
      user: {},
      currentUser: this.store.user,
    };
  },
  methods: {
    async getWtsByTeam() {
      if (this.currentUser.role === "manager") {
        const team = (
          await axios.get(`/api/teams/manager/${this.currentUser.id}`)
        ).data;
        console.log(team, "team");
        this.userTeamId = this.user.team_id;
        const response2 = await axios.get(
          `/api/working_times/teams/${team.id}`
        );
        const userAllWts = response2.data.data.map((workingtimes) => {
          return {
            name: workingtimes.username,
            data: workingtimes.working_times.map((workingtime) => {
              return calculateTotalWorkingTimeinMinutes(workingtime);
            }),
          };
        });
        const totalWtsByUser = userAllWts.map((workingtimes) => {
          return {
            name: workingtimes.name,
            data: workingtimes.data.reduce((a, b) => a + b, 0),
          };
        });
        const totalWts = totalWtsByUser.map((workingtimes) => {
          return workingtimes.data;
        });
        const sum = totalWts.reduce((a, b) => a + b, 0);
        const totalWtsByUserInPercent = totalWtsByUser.map((workingtimes) => {
          return {
            name: workingtimes.name,
            data: (workingtimes.data / sum) * 100,
          };
        });
        let xPieGraph = totalWtsByUserInPercent.map((workingtimes) => {
          return workingtimes.data;
        });
        let yPieGraph = totalWtsByUserInPercent.map((workingtimes) => {
          return workingtimes.name;
        });
        this.pieSeries = xPieGraph;

        this.pieOptionsChart = {
          labels: yPieGraph,
        };

        console.log("this.pieOptionsChart.labels", this.pieOptionsChart);
      }
    },
  },
  mounted() {
    this.getWtsByTeam();
  },
};
</script>
