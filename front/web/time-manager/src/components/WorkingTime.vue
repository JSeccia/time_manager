<template>
    working time user id is {{ $route.params.id }}

</template>

<script>
import axios from "axios";
export default {
    computed: {
        workingTimeId() {
            return parseInt(this.$route.params.id)
        }
    // },
    // methods: {
    //     workingTime() {
    //         axios
    //             .get(`http://192.168.76.161:4000/api/working_times/${this.workingTimeId}`)
    //             .then((response) => {
    //                 if (response.data.data.length > 0) {
    //                     let workingTimes = response.data.data;
    //                     console.log(workingTimes);
    //                     // return this.workingTime.find((workingTime) => workingTime.id === this.workingTimeId)
    //                 } else {
    //                     window.alert("No employee or working times found");
    //                 }
    //             });
    //     },
    // },
    }
}
</script>