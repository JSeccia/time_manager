<template>
    <div>
        <ChartComponent />
    </div>
</template>

<script>
import { defineComponent, defineAsyncComponent } from 'vue';


const ChartComponent = defineAsyncComponent(() => import('src/components/ChartComponent.vue'));

export default defineComponent({
    name: 'ChartsPage',

    components: {
        ChartComponent,
    },
});

</script>