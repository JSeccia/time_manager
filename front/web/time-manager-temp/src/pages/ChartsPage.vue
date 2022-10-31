<template>
    <div>
        <ChartComponent />
    </div>
</template>

<script>
import { defineComponent } from 'vue';
import ChartComponent from 'src/components/ChartComponent.vue';

export default defineComponent({
    name: 'ChartsPage',

    components: {
        ChartComponent,
    },
});

</script>