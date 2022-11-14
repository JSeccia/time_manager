<template>
  <main class="main_charts">
    <h1>Chart Activity</h1>

    <div class="Global_charts">
      <PieComponent />
    </div>
    <!-- <div class="bar_chart">
      <BarComponent />
    </div>
    -->

    <div class="btn_charts">
      <q-btn
        class="WT_button"
        push
        color="green-10"
        label="Team Working times"
        @click="wtButton"
      />
      <q-btn
        class="Hours_button"
        push
        color="green-10"
        label="Team last clock"
        @click="clockButton"
      />
    </div>
  </main>
</template>

<script>
import { defineComponent } from "vue";
import { useUserStore } from "src/stores/store-users";
import { calculateTotalWorkingTimeinMinutes } from "src/utils/utils";
import moment from "moment";
import PieComponent from "./PieComponent.vue";
// import BarComponent from "./BarComponent.vue";

export default defineComponent({
  name: "ChartComponent",
  components: {
    PieComponent,
    // BarComponent,
  },
  setup() {
    const store = useUserStore();
    return {
      store,
    };
  },
  data() {
    return {
      currentUser: this.store.user,
    };
  },
  methods: {
    wtButton() {
      console.log("wtButton");
      this.$router.push("/workingtimes");
    },
    clockButton() {
      console.log("clockButton");
      this.$router.push("/clocks");
    },
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
}

.main_charts h1 {
  font-size: 25px;
  text-align: center;
  font-weight: bold;
  height: 12%;
  width: 60%;
}

.Global_charts {
  width: 100%;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 0 0 0 2px white;
  border-radius: 8px;
  position: relative;
}

.WT_charts,
.bar_chart {
  width: 75%;
  height: 75%;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  background-color: #9ae691;
  box-shadow: 0 0 0 2px white;
  border-radius: 8px;
  margin: 0 1%;
}

.bar_chart {
  display: flex;
  flex-direction: column;
}

.WT_charts .title_WT {
  height: 10%;
  width: 100%;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}

.WT_charts .title_WT h2,
.bar_chart h2 {
  font-size: 26px;
  text-align: center;
  color: #fff;
  font-weight: bold;
}

.WT_charts .vue-apexcharts {
  display: flex;
  flex-direction: column;
  align-items: center;
  height: 50%;
  width: 50%;
}

.WT_charts
  .vue-apexcharts
  .apexcharts-canvas
  .apexcharts-inner
  .apexcharts-text {
  fill: #dce4e8;
  font-weight: normal;
}

.btn_charts {
  width: 100%;
  height: 5%;
  display: flex;
  justify-content: center;
  position: absolute;
  bottom: 0;
}

.btn_charts .WT_button,
.btn_charts .Hours_button {
  width: 25%;
  height: 30%;
  margin: 2%;
}
</style>
