<template>
    <p>Chart template</p>
    <div class="data">
        <button v-on:click="addData()">ADD DATA</button>
        <button v-on:click="removeData()">REMOVE DATA</button>
    </div>

    <div class="workingtimes">
        <button @click="$router.push('/workingtimes')">Click to go on WorkingTimes</button>
    </div>
    <div class="clock">
        <button @click="$router.push('/clock')">Click to go to Clocks</button>"
    </div>
    <div class="home">
        <button @click="$router.push('/')">Click to go to Home</button>
    </div>
</template>

<script>

export default {
  name: "Chart",
    data() {
        return {
            counter: 0
        }
  },
}

</script>