<template>
    <UsersComponent />
</template>

<script>
import axios from "axios";
import UsersComponent from "src/components/UsersComponent.vue";
import { defineComponent } from "vue";


export default {
    name: "UsersPage",
    components: {
        UsersComponent,
    },
};
</script>


