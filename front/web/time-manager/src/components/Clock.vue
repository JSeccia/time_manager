<template>
    <main>
        <div class="text1">
            <p>Clock template</p>
        </div>
    </main>
    <div class="workingtimes">
        <button @click="$router.push('/workingtimes')">Click to go on WorkingTimes</button>
    </div>
    <div class="chart">
        <button @click="$router.push('/chart')">Click to go to Chart</button>
    </div>
    <div class="home">
        <button @click="$router.push('/')">Click to go to Home</button>
    </div>
</template>

<style scoped>
.workingtimes {
    margin-top: 2rem;
    border-radius: 80px;
}



.chart {
    margin-top: 2rem;
}

.home {
    margin-top: 2rem;
}

.text1 {
    text-align: center;
    margin-top: 2rem;
    font-weight: bold;
}
</style>

<script>
</script>