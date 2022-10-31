<template>
    <div>
        <WorkingTimes />
    </div>
</template>

<script>
import { defineComponent } from 'vue';
import WorkingTimes from 'src/components/WorkingTimes.vue';

export default defineComponent({
    name: 'WorkingTimes',

    components: {
        WorkingTimes,
    },
    },
);

</script>