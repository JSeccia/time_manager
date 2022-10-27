<template>
    <main>
        <p>Clock template</p>
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

<script>
</script>