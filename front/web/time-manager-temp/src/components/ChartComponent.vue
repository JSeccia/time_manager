<template>

    <main class="main_charts">
        <div class="title_chart">
            <h1>Latest employees Activity</h1>
        </div>


        <div class="Global_charts">
            <div class="WT_charts">
                <apexchart type="donut" width="380" :options="chartOptions" :series="series"></apexchart>
            </div>
            <div class="hours_charts">

                <apexchart type="bar" height="350" :options="Optionschart" :series="seefojf"></apexchart>

            </div>
        </div>


        <div class="btn_charts">
            <q-btn class="WT_button" push color="green-10" label="Working Times" />
            <q-btn class="Hours_button" push color="green-10" label="Hours declared" />
        </div>
    </main>




</template>



<script>

import { defineComponent } from 'vue';
//import apexcharts from 'src/boot/apexcharts';

export default defineComponent({
    name: 'ChartComponent',
    data() {
        return {
            series: [44, 55, 41, 17, 15],
            chartOptions: {
                chart: {
                    type: 'donut',
                },
                responsive: [{
                    breakpoint: 480,
                    options: {
                        chart: {
                            width: 200
                        },
                        legend: {
                            position: 'bottom'
                        }
                    }
                }]
            },
        }
    },
    data() {
        return {
            seefojf: [{
                data: [400, 430, 448, 470, 540, 580, 690, 1100, 1200, 1380]
            }],
            Optionschart: {
                chart: {
                    type: 'bar',
                    height: 350
                },
                plotOptions: {
                    bar: {
                        borderRadius: 4,
                        horizontal: true,
                    }
                },
                dataLabels: {
                    enabled: false
                },
                xaxis: {
                    categories: ['South Korea', 'Canada', 'United Kingdom', 'Netherlands', 'Italy', 'France', 'Japan',
                        'United States', 'China', 'Germany'
                    ],
                }
            },
        }
    }
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
    background-color: #9AE691;
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
    background-color: #9AE691;
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