<template>
    <main>
        <div class="text">
            <p>Chart template</p>
        </div>
    </main>
    <div class="container">
        <Bar v-if="loaded" :chart-data="chartData" />
    </div>
    <div class="data">
        <p><b>Modifier des données: </b></p>
        <button v-on:click="addData()">ADD DATA</button>
        <button v-on:click="removeData()">REMOVE DATA</button>
    </div>

    <div class="workingtimes">
        <button @click="$router.push('/workingtimes')">Click to go on WorkingTimes</button>
    </div>
    <div class="clock">
        <button @click="$router.push('/clocks')">Click to go to Clocks</button>"
    </div>
    <div class="home">
        <button @click="$router.push('/')">Click to go to Home</button>
    </div>
</template>

<style>
.text {
    text-align: center;
    margin-top: 2rem;
    font-weight: bold;
}

.data {
    margin-top: 2rem;
    margin-bottom: 2rem;
    font-weight: bold;
}
</style>

<script>


</script>