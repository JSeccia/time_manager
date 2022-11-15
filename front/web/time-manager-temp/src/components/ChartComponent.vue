<template>
  <main class="main_charts">
    <h1>Chart Activity</h1>

    <div class="Global_charts">
      <PieComponent />
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
    </div>
    <!-- <div class="bar_chart">
      <BarComponent />
    </div>
    -->

    
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
  height: 80%;
  width: 100%;
}

.main_charts h1 {
  font-size: 25px;
  text-align: center;
  font-weight: bold;
  height: 25%;
  width: 60%;
  margin: 0 auto;
}

.Global_charts {
  width: 75%;
  height: 10%;
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
  height: 15%;
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
  width: 40%;
  height: 40%;
  display: flex;
  justify-content: center;
  position: absolute;
  top: 270px;
}

.btn_charts .WT_button,
.btn_charts .Hours_button {
  width: 50%;
  height: 100%;
  margin: 2%;
}
</style>
