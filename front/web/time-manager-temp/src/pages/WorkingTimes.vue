<template>
    <div>
        <WorkingTimesTest />
    </div>
</template>

<script>
import { defineComponent } from 'vue';
import WorkingTimesTest from 'src/components/WorkingTimesTest.vue';

export default defineComponent({
    name: 'WorkingTimes',

    components: {
        WorkingTimesTest,
    },
});

</script>