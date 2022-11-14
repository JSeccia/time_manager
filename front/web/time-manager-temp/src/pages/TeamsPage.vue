<template>
    <TeamsComponent />
</template>

<script>
import axios from "axios";
import TeamsComponent from "src/components/TeamsComponent.vue";
import { defineComponent } from "vue";


export default {
    name: "TeamsPage",
    
    components: {
        TeamsComponent,
    },
};
</script>


