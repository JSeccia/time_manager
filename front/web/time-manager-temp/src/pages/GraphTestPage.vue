<template>
    <div>
        <GraphTest />
    </div>

</template>



<script>
import { defineComponent } from 'vue';
import GraphTest from 'src/components/GraphTest.vue';


export default defineComponent({
    name: 'GraphTestPage',

    components: {
        GraphTest,
    },
})



</script>
