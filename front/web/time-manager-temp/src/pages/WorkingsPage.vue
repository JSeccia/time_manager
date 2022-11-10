<template>
    <div>
        <WorkingsComponent />
    </div>
</template>


<script>

import { defineComponent } from 'vue';
import WorkingsComponent from 'src/components/WorkingsComponent.vue';

export default defineComponent({
    name: 'WorkingsPage',

    components: {
        WorkingsComponent,
    },
});

</script>