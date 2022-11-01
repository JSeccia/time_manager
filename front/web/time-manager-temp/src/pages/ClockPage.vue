<template>
    <div>
        <ClockComponent />
    </div>
</template>

<script>
import { defineComponent } from 'vue';
import ClockComponent from 'src/components/ClockComponent.vue';

export default defineComponent({
    name: 'ClockPage',

    components: {
        ClockComponent,
    },

});
</script>