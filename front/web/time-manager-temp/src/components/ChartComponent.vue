<template>
  <main class="main_charts">
    <div class="title_chart">
      <h1>CHART ACTIVITY</h1>
    </div>

    <div class="Global_charts">
      <div class="WT_charts">
        <apexchart
          type="pie"
          :options="pieOptionsChart"
          :series="pieSeries"
        ></apexchart>
      </div>
      <div class="hours_charts">
        <apexchart
          type="bar"
          height="350"
          :options="chartOptions"
          :series="series"
        ></apexchart>
      </div>
    </div>

    <div class="btn_charts">
      <q-btn class="WT_button" push color="green-10" label="Chart Times" />
      <q-btn class="Hours_button" push color="green-10" label="Chart Hours" />
    </div>
  </main>
</template>

<script>
import { defineComponent } from "vue";
import axios from "axios";
import { useUserStore } from "src/stores/store-users";
import { calculateTotalWorkingTimeinMinutes } from "src/utils/utils";
//import apexcharts from 'src/boot/apexcharts';

export default defineComponent({
  name: "ChartComponent",
  setup() {
    const store = useUserStore();
    return {
      store,
    }
  },
  data() {
    return {
      series: [
        {
          name: "Hours Worked",
          data: [126, 85, 111, 148, 127, 135, 91, 144, 94],
        },
        {
          name: "Working Hours",
          data: [150, 150, 150, 150, 150, 150, 150, 150, 150],
        },
      ],
      chartOptions: {
        chart: {
          type: "bar",
          height: 350,
        },
        plotOptions: {
          bar: {
            horizontal: false,
            columnWidth: "55%",
            endingShape: "rounded",
          },
        },
        dataLabels: {
          enabled: false,
        },
        stroke: {
          show: true,
          width: 2,
          colors: ["transparent"],
        },
        xaxis: {
          categories: [
            "Feb",
            "Mar",
            "Apr",
            "May",
            "Jun",
            "Jul",
            "Aug",
            "Sep",
            "Oct",
          ],
        },
        yaxis: {
          title: {
            text: "h (hours)",
          },
        },
        fill: {
          opacity: 1,
        },
        tooltip: {
          y: {
            formatter: function (val) {
              return "H " + val + " Hours worked";
            },
          },
        },
      },
      pieSeries: [],
      pieOptionsChart: {
        chart: {
          width: "100%",
          type: "pie",
        },
        labels: [],
        theme: {
          monochrome: {
            enabled: false,
          },
        },
        plotOptions: {
          pie: {
            dataLabels: {
              offset: -5,
            },
          },
        },
        title: {
          text: "yo",
        },
        dataLabels: {
          formatter(val, opts) {
            const name = opts.w.globals.labels[opts.seriesIndex];
            return [name, val.toFixed(0) + "%"];
          },
        },
        legend: {
          show: false,
        },
      },
      userTeamId: {},
      user: {},
      currentUser: this.store.user,
    };
  },
  methods: {
    async getWtsByTeam() {
      const response = await axios.get(`/api/users/${this.currentUser.id}`)
        this.user = response.data.data;
        this.userTeamId = this.user.team_id;
        const response2 = await axios.get(`/api/working_times/teams/${this.userTeamId}`)
        const userAllWts = response2.data.data.map((workingtimes) => {
          return {
            name: workingtimes.username,
            data: workingtimes.working_times.map((workingtime) => {
              return calculateTotalWorkingTimeinMinutes(workingtime);
            }),
          }
        })
        const totalWtsByUser = userAllWts.map((workingtimes) => {
          return {
            name: workingtimes.name,
            data: workingtimes.data.reduce((a, b) => a + b, 0),
          }
        })
        const totalWts = totalWtsByUser.map((workingtimes) => {
          return workingtimes.data;
        })
        const sum = totalWts.reduce((a, b) => a + b, 0);
        const totalWtsByUserInPercent = totalWtsByUser.map((workingtimes) => {
          return {
            name: workingtimes.name,
            data:(workingtimes.data / sum) * 100,
          }
        })
        console.log("totalWtsByUserInPercent", totalWtsByUserInPercent);
        let xPieGraph = totalWtsByUserInPercent.map((workingtimes) => {
          return workingtimes.data;
        })
        console.log("xPieGraph", xPieGraph);
        let yPieGraph = totalWtsByUserInPercent.map((workingtimes) => {
          return workingtimes.name;
        })
        console.log("yPieGraph", yPieGraph);
        this.pieSeries = 
          xPieGraph;
        console.log("this.pieSeries", this.pieSeries);
        this.pieOptionsChart = {
          labels: yPieGraph,
        }
        
        console.log("this.pieOptionsChart.labels", this.pieOptionsChart);
    },
  },
  mounted() {
    this.getWtsByTeam();
  },
});
</script>

<style>
.main_charts {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: space-between;
  height: 100vh;
  width: 100%;
  border: 1px solid black;
}

.title_chart {
  width: 70%;
  height: 15%;
  display: flex;
  justify-content: center;
  align-items: center;
}

.title_chart h1 {
  font-size: 25px;
  font-weight: bold;
  border-bottom: 2px solid black;
}

.Global_charts {
  width: 100%;
  height: 83%;
  display: flex;
  align-items: center;
  justify-content: space-between;
  box-shadow: 0 0 0 2px white;
  border-radius: 8px;
  position: relative;
}

.WT_charts {
  width: 50%;
  height: 85%;
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: #9ae691;
  box-shadow: 0 0 0 2px white;
  border-radius: 8px;
  margin: 1%;
}

.hours_charts {
  width: 50%;
  height: 85%;
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: #9ae691;
  box-shadow: 0 0 0 2px white;
  border-radius: 8px;
  margin: 1%;
}

.btn_charts {
  width: 100%;
  height: 10%;
  display: flex;
  justify-content: space-around;
  position: absolute;
  bottom: 0;
}

.btn_charts .WT_button,
.btn_charts .Hours_button {
  width: 15%;
  height: 15%;
  margin: 4%;
}
</style>
